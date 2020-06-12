
// Con base en ejemplo de https://www.chartjs.org/samples/latest/charts/line/basic.html

window.chartColors = {
  red: 'rgb(255, 99, 132)',
  orange: 'rgb(255, 159, 64)',
  yellow: 'rgb(255, 205, 86)',
  green: 'rgb(75, 192, 192)',
  blue: 'rgb(54, 162, 235)',
  purple: 'rgb(153, 102, 255)',
  grey: 'rgb(201, 203, 207)'
};


function chartjs_serietiempo_vs() {
  d3.csv("serie-sexonac.csv").then(function(datos) { 
    procesar_datos(datos) 
  })
};

function procesar_datos(filas) {
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
    fecha = f; //parseTime(f)
    x.push(fecha)
    y1.push(datos2[f]['F'])
    y2.push(datos2[f]['M'])
    y3.push(datos2[f]['S'])
  })

  hacerSerieTiempoChartjs( x, y1, y2, y3);
}

function hacerSerieTiempoChartjs( x, y1, y2, y3) {

  var config = {
    type: 'line',
    data: {
      labels: x,
      datasets: [{
        label: 'F',
        backgroundColor: window.chartColors.red,
        borderColor: window.chartColors.red,
        data: y1,
        fill: false,
      }, {
        label: 'M',
        fill: false,
        backgroundColor: window.chartColors.green,
        borderColor: window.chartColors.green,
        data: y2
      }, {
        label: 'S',
        fill: false,
        backgroundColor: window.chartColors.blue,
        borderColor: window.chartColors.blue,
        data: y3
      }]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'Serie de tiempo por sexo de nacimiento'
      },
      tooltips: {
        mode: 'index',
        intersect: false,
      },
      hover: {
        mode: 'nearest',
        intersect: true
      },
      scales: {
        xAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: 'Fecha'
          }
        }],
        yAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: ''
          }
        }]
      }
    }
  };


  var ctx = document.getElementById('canvas').getContext('2d');
  window.myLine = new Chart(ctx, config);

  //document.getElementById('randomizeData').addEventListener('click', function() {
  //  config.data.datasets.forEach(function(dataset) {
  //    dataset.data = dataset.data.map(function() {
  //      return randomScalingFactor();
  //    });
  //  });

  // window.myLine.update();
  //});
}

export default chartjs_serietiempo_vs;
