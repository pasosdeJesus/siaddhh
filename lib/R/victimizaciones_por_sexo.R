# Victimizaciones por sexo de nacimiento
# Desarrollo inicial de Andres Mauricio Galeano

# Nomenclatura: shiny usa CamelCase comenzando en minúscula
# R usa más _
# Usamos más _
# Variables que podamos poner en español, las ponemos en español

print("** victimizaciones por sexo")
if(!require(shiny)){
  install.packages("shiny", repos = "https://www.icesi.edu.co/CRAN/")
  library(shiny)
}
if(!require(ggplot2)){
  install.packages("ggplot2", repos = "https://www.icesi.edu.co/CRAN/")
  library(ggplot2)
}
if(!require(rio)){
  install.packages("rio", repos = "https://www.icesi.edu.co/CRAN/")
  library(rio)
}
if(!require(plyr)){
  install.packages("plyr", repos = "https://www.icesi.edu.co/CRAN/")
  library(plyr)
}
if(!require(dplyr)){
  install.packages("dplyr", repos = "https://www.icesi.edu.co/CRAN/")
  library(dplyr)
}
if(!require(svglite)){
  install.packages("svglite", repos = "https://www.icesi.edu.co/CRAN/")
  library(svglite)
}


# Preparación de datos
tabla <- import("lib/R/victimizaciones_individuales.csv")
tabla$sexonac <- factor(tabla$sexonac)
tabla$fecha <- as.Date(tabla$fecha)
tabla$categoria_id <- factor(tabla$categoria_id)

print("Por generar interfaz de usuario")
# Interfaz de usuario
interfaz <- fluidPage(
  headerPanel('Victimizaciones por sexo de nacimiento'),
  fluidRow(
    column(width=4,
      wellPanel(width=12, title = "Filtro", status = "info",
        #solidHeader = T, 
        dateRangeInput(inputId = "rango",
          label = "Rango de fechas de la victimización",
          start = min(tabla$fecha),
          end = max(tabla$fecha),
          format = "yyyy-mm-dd"),
        selectInput("sexonac", "Sexos de nacimiento",
          choices = levels(tabla$sexonac),
          multiple = T,
          selected = levels(tabla$sexonac)),
        selectInput("categoria_id", "Categorias incluidas",
          choices = levels(tabla$categoria_id),
          multiple = T,
          selected = levels(tabla$categoria_id))
       )
      ),
    column(width=8,
      wellPanel(width=12,
        wellPanel(
          plotOutput("graficar_serie"),
          downloadButton("descargar_serie_SVG", "SVG"),
          downloadButton("descargar_serie_PNG", "PNG"),
          downloadButton("descargar_serie_CSV", "CSV")
          ),
        wellPanel(
          plotOutput("graficar_total"),
          downloadButton("descargar_total_SVG", "SVG"),
          downloadButton("descargar_total_PNG", "PNG"),
          downloadButton("descargar_total_CSV", "CSV")
        )
      )
    )
  )
)

print("Por definir servidor")
# Lógica para dibujar en la interfaz
servidor <- function(input, output) {

  serie <- reactive({
    plyr::count(subset(tabla, sexonac %in% input$sexonac &
        categoria_id %in% input$categoria_id &
        fecha >= input$rango[1] & fecha <= input$rango[2]),
      c('fecha', 'sexonac'))
  })

  total <- reactive({
    plyr::count(serie(), c('sexonac'))
  })

  graficar_serie <- reactive({
    ggplot(data = serie(), aes(x = fecha, y = freq, group = sexonac, 
        colour=sexonac)) +
    geom_line() + geom_point() +
    labs(title='Serie de tiempo por sexo de nacimiento',
      y='Victimizaciones', x= 'Fecha') +
    theme(legend.position="top", legend.title = element_blank())
  })

  graficar_total <- reactive({
    ggplot(data = total(), aes(x = sexonac, y = freq, fill = sexonac))+
      geom_bar(stat="identity", position=position_dodge()) +
      geom_text(aes(label=freq), vjust=1.6, color="white",
        position = position_dodge(0.9), size=3.5) +
      labs(title='Totales por sexo de nacimiento',
        y='Victimizaciones', x= 'Sexo de nacimiento') +
      theme(legend.position="none")
  })

  output$graficar_serie <- renderPlot({
    graficar_serie()
  })

  output$graficar_total <- renderPlot({
    graficar_total()
  })


  output$descargar_serie_SVG<- downloadHandler(
    filename = function() { paste("serie-sexonac", ".svg", sep = "") },
    content = function(nomarc){
      ggsave(nomarc, graficaSerie())
    }
  )

  output$descargar_serie_PNG<- downloadHandler(
    filename = function() {paste("serie-sexonac", ".png", sep = "")},
    content = function(nomarc){
      ggsave(nomarc, graficaSerie())
    }
  )

  output$descargar_serie_CSV<- downloadHandler(
    filename = function() {paste("serie-sexonac", ".csv", sep = "")},
    content = function(nomarc){
      write.csv(serie(), nomarc)
    }
  )

  output$descargar_total_SVG <- downloadHandler(
    filename = function() {paste("total-sexonac", ".svg", sep = "")},
    content = function(nomarc){
      ggsave(nomarc, graficaSerie())
    }
  )

  output$descargar_total_PNG <- downloadHandler(
    filename = function() {paste("total-sexonac", ".png", sep = "")},
    content = function(nomarc){
      ggsave(nomarc,graficaSerie())
    }
  )

  output$descargar_total_CSV <- downloadHandler(
    filename = function() {paste("total-sexonac", ".csv", sep = "")},
    content = function(nomarc){
      write.csv(total(), nomarc)
    }
  )
}

print("Por ejecutar shinyApp")
# La aplicación se ejecutaría así:
shinyApp(ui = interfaz, server = servidor, 
  options = list(host = "181.143.184.115", port = 2902))

