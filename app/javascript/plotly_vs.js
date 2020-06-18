
// Se intento con webpacker
// var Plotly = require('plotly.js')
// window.Plotly = Plotly
//
// Desde javascript/packs/application.js se incluyó:
// import hacer_serietiempo from '../serietiempo_plotly'
// que operó dejando al final de este archivo
// export default hacer_serietiempo
//
// Sin embargo al cargar la página producía:
// browser.js:17 Uncaught TypeError: Cannot read property 'appendChild' of null
//      at getSizeBrutal (browser.js:17)
//      ...
//      at __webpack_require__ (bootstrap:19)
//      at Object../node_modules/plotly.js/src/plots/gl3d/scene.js (scene.js:10)
// Y revisando la función llamadora de la que falla dice:
//      var PIXELS_PER_INCH = getSizeBrutal('in', document.body); // 96
// Así que document.body es null cuando es cargada, que tiene sentido
// teniendo en cuenta que webpack no carga módulos de manera dinámica sino
// estática antes de cargar páginas y lo que genera posiblemente se cargue antes 
// que la página. 
//
// Consideramos entonces que la versión de plotly que queremos usar no es compatible
// con webpack y webpacker
//
// Volvemos al método que si funcionó que usar CND para cargar plotly dinámicamente
// cuando se presenta la página que la requiere, i.e:
// <script src='https://cdn.plot.ly/plotly-latest.min.js'></script>
//
// Podríamos usar este javascript con sprockets, pero sería unirlo al espacio global.
//
// Al usarlo de manera independiente de sprockets podría usarse el sistema de 
// módulos de ES6.
//
// Este enfoque basta para aplicaciones WEB (conectadas continuo a Internet).




// Con base en   https://plotly.com/javascript/line-charts/#styling-line-plot
function plotly_serietiempo_vs() {
  Plotly.d3.csv("serie-sexonac.csv", function(err, datos){ procesar_datos(datos) } );

};

function procesar_datos(filas) {
  var x = [], y1 = [], y2 = [], y3 = [];
  
  function unpack(datos, columna){
    return datos.map(function(fila){ return fila[columna];});
  }
  var colsexo = unpack(filas, 'sexonac')
  var colfecha = unpack(filas, 'fecha')
  var colfreq = unpack(filas, 'freq')
  
  var listadesexos = hallarvalunicos(colsexo)
  var fechasPresentes = [];
  var freqsPresentes = [];
  
  function hallarvalunicos(valores){
    var valoresunicos = []
    for (var i = 0; i < valores.length; i++ ){
              if (valoresunicos.indexOf(valores[i]) === -1 ){
                valoresunicos.push(valores[i]);
                }
          }
    return valoresunicos
  }
  
  function obtenerSegunSexo(sexoSeleccionado) {
    fechasPresentes = [];
    freqsPresentes = [];
    for (var i = 0 ; i < colsexo.length ; i++){
      if ( colsexo[i] === sexoSeleccionado ) {
        fechasPresentes.push(colfecha[i]);
        freqsPresentes.push(colfreq[i]);
      }
    }
  };

  var filtrosContainer = document.querySelector('.filtros'),
    plotContainer = document.querySelector('[data-num="0"'),
    plotEl = plotContainer.querySelector('.plot'),
    sexoSelector = filtrosContainer.querySelector('#sexonac');

  function asignarOpciones(arraydevalores, selector) {
    for (var i = 0; i < arraydevalores.length;  i++) {
                  var opcionActual = document.createElement('option');
                  opcionActual.selected = true;
                  opcionActual.text = arraydevalores[i];
                  selector.appendChild(opcionActual);
        }
    }
  
  asignarOpciones(listadesexos, sexoSelector);
  function graficarSegunFiltro(sexoSeleccionado) {
    var trazosTotales = []
    var colors =['rgb(64, 219, 82)', 'rgb(219, 64, 82)', 'rgb(64, 82, 219)'] 
    for (var i=0; i < sexoSeleccionado.length; i++){
      obtenerSegunSexo(sexoSeleccionado[i]);
      var trazo = {
           x: fechasPresentes,
           y: freqsPresentes,
           type: 'scatter',
           mode: 'lines+markers',
           name: sexoSeleccionado[i],
           line: {
             color: colors[i],
             width: 1
           },
           marker: {
             size: 12,
             opacity: 0.5
           }
       };
      trazosTotales.push(trazo)
    }
    var data = trazosTotales;
    var layout = {
                  title:'Grafica para ' + sexoSeleccionado,
              };

    Plotly.newPlot('divplot', data, layout, {showSendToCloud: true});
  };
  function actualizaGrafica(){
    function getSelectValues(select) {
        var result = [];
        var options = select && select.options;
        var opt;

        for (var i=0, iLen=options.length; i<iLen; i++) {
              opt = options[i];

              if (opt.selected) {
                      result.push(opt.value || opt.text);
                    }
            }
        return result;
    }
    var sexoselegidos = getSelectValues(sexoSelector)
    graficarSegunFiltro(sexoselegidos);
  }
  actualizaGrafica()
  sexoSelector.addEventListener('change', actualizaGrafica, false);

  //var parseTime = d3.timeParse("%Y-%m-%d");

  var datos2 = {}
  // format the data
  filas.forEach(function(r) {
    if (typeof datos2[r.fecha] == 'undefined') {
      datos2[r.fecha] = {F: 0, M: 0, S: 0}
    }
    datos2[r.fecha][r.sexonac] += +r.freq
  })
  Object.keys(datos2).sort().forEach(function(f) {
    var fecha = f; //parseTime(f)
    x.push(fecha)
    y1.push(datos2[f]['F'])
    y2.push(datos2[f]['M'])
    y3.push(datos2[f]['S'])
  })


  hacerSerieTiempoPlotly( x, y1, y2, y3);
}

function hacerSerieTiempoPlotly( x, y1, y2, y3){
  var plotDiv = document.getElementById("plot");
  var trazos = [
    {
      x: x, 
      y: y1,
      type: 'scatter',
      mode: 'lines',
      name: 'F',
      line: {
        color: 'rgb(219, 64, 82)',
        width: 1
      }
    },
    {
      x: x,
      y: y2,
      type: 'scatter',
      mode: 'lines',
      name: 'M',
      line: {
        color: 'rgb(64, 219, 82)',
        width: 1
      }
    },
    {
      x: x,
      y: y3,
      type: 'scatter',
      mode: 'lines',
      name: 'S',
      line: {
        color: 'rgb(64, 82, 219)',
        width: 1
      }
    }
  ];

  var config={
    responsive: true, 
    displaylogo: false, 
    locale: 'es'
  }

  Plotly.newPlot('div_serietiempo', trazos, 
    {title: 'Serie de tiempo por sexo de nacimiento'}, config);
};

export default plotly_serietiempo_vs;
