
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
  Plotly.d3.csv("serie-sexonac.csv", function(datos){ procesar_datos(datos) } );

};

function procesar_datos(filas) {

  console.log(filas);
  var x = [], y1 = [], y2 = [], y3 = [];

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
