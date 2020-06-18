
// Autores: Vladimir Támara y Luis Alejandro Cruz.
// Con base en   https://plotly.com/javascript/line-charts/#styling-line-plot
//
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

var ejex = []  // Valores en eje x
var etiquetasPosibles = []  // Etiquetas posibles
var series_ejey = {} // Series posibles en eje y indexadas por etiquetas
var trazosPresentados = [] // de plotly llenados por actualiarTrazosPresentados

var totalesEtiqueta = {} // Totales por etiqueta

// Recibe etiquetas por presentar y actualiza variable trazosPresentados
// dejando justo las series de series_ejey que corresponden a esas etiquetas
function actualizarTrazosPresentados(etiquetas) {
  var etiquetasP = []
  var i = 0
  trazosPresentados.forEach(function(t) {
    etiquetasP.push(t.name)
    i++;
  });
  var eo = etiquetas.sort()
  var epo = etiquetasP.sort()
  var c = 0
  var cp = 0
  var agregar = []
  var eliminar = []
  while (c < eo.length || cp < epo.length) {
    if (cp >= epo.length || eo[c] < epo[cp]) {
      agregar.push(eo[c])
      c++
    } else if (c >= eo.length || eo[c] > epo[cp]) {
      eliminar.push(epo[cp])
      cp++
    } else {
      c++
      cp++
    }
  }
  eliminar.forEach(function (e) {
    var indpe = trazosPresentados.find(t => t.name == e);
    trazosPresentados.splice(indpe, 1)
  })
  agregar.forEach(function (e) {
    trazosPresentados.push({
      x: ejex, 
      y: series_ejey[e],
      stackgroup: 'uno',
      //type: 'scatter',
      //mode: 'lines',
      name: e,
      //line: {
        //color: colores[e],
       // width: 1
      //}
    })
  })

  var configuracion = {
    responsive: true, 
    displaylogo: false, 
    locale: 'es',
    showEditInChartStudio: true,
    plotlyServerURL: "https://chart-studio.plotly.com",
    height: 340, 
  }

  Plotly.newPlot('div_serietiempo', trazosPresentados, 
    {title: 'Serie de tiempo de actos', showlegend: false},
    configuracion);

  var valorBarras = []
  etiquetas.forEach(function (e) {
    valorBarras.push(totalesEtiqueta[e])
  })
  var barras = [{
    x: etiquetas,
    y: valorBarras,
    type: 'bar'
  }]
  Plotly.newPlot('div_barras', barras,
    {title: 'Actos por presunto responsable'},
    configuracion);

}


function plotly_serietiempo_actos() {
  Plotly.d3.csv("actos_individuales.csv", function(err, datos) { 
    procesar_datos(datos, 'presponsable') 
  });
};

function procesar_datos(filas, variable) {

  var contenedorFiltros = document.querySelector('.filtros'),
    selectorCategoria= contenedorFiltros.querySelector('#presponsable');

  function asignarOpciones(arraydevalores, selector) {
    for (var i = 0; i < arraydevalores.length;  i++) {
      var opcionActual = document.createElement('option');
      opcionActual.selected = true;
      opcionActual.text = arraydevalores[i];
      selector.appendChild(opcionActual);
    }
    $(selector).trigger('chosen:updated')
  }


  var datos2 = {}
  var dicEtiquetas = {}
  filas.forEach(function(r) {
    dicEtiquetas[r[variable]] = 0
    if (typeof datos2[r.fecha] == 'undefined') {
      datos2[r.fecha] = {}
    }
    if (typeof datos2[r.fecha][r[variable]] == 'undefined') {
      datos2[r.fecha][r[variable]] = +r.cuenta
    } else {
      datos2[r.fecha][r[variable]] += +r.cuenta
    }
  })

  etiquetasPosibles = Object.keys(dicEtiquetas)
  totalesEtiqueta = {}
  Object.keys(datos2).sort().forEach(function(f) {
    var fecha = f; //parseTime(f)
    ejex.push(fecha)
    etiquetasPosibles.forEach(function(e) {
      if (typeof datos2[f][e] == 'undefined') {
        datos2[f][e] = 0
      }
      if (typeof series_ejey[e] == 'undefined') {
        series_ejey[e] = []
      }
      series_ejey[e].push(datos2[f][e])
      if (typeof totalesEtiqueta[e] == 'undefined') {
        totalesEtiqueta[e] = datos2[f][e]
      } else {
        totalesEtiqueta[e] += datos2[f][e]
      }
    })
  })
  var colores = {
    'F': 'rgb(219, 64, 82)',
    'M': 'rgb(64, 219, 82)',
    'S': 'rgb(64, 82, 219)'
  }

  function actualizarGrafica(){
    function opcionesElegidas(seleccionm) {
      var res = [];
      var opciones = seleccionm && seleccionm.options;
      var op;

      for (var i = 0, t = opciones.length; i < t; i++) {
        op = opciones[i];

        if (op.selected) {
          res.push(op.value || op.text);
        }
      }
      return res;
    }
    var opelegidas = opcionesElegidas(selectorCategoria)
    actualizarTrazosPresentados(opelegidas);
  }


  asignarOpciones(etiquetasPosibles, selectorCategoria);
  actualizarGrafica()
  selectorCategoria.addEventListener('change', actualizarGrafica, false);
  $(selectorCategoria).chosen().change(actualizarGrafica);

}


export default plotly_serietiempo_actos;
