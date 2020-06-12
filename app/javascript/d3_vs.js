// Con base en ejemplo de 

function d3_serietiempo_vs() {
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

  hacerSerieTiempoD3( x, y1, y2, y3);
}

function hacerSerieTiempoD3( x, y1, y2, y3) {
  d3.selectAll("div")
    .append("p")
    .text("Hello, World!")

  var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 480 - margin.left - margin.right,
    height = 250 - margin.top - margin.bottom;

  // parse the date / time
  var parseTime = d3.timeParse("%Y-%m-%d");

  // set the ranges
  var x = d3.scaleTime().range([0, width]);
  var y = d3.scaleLinear().range([height, 0]);

  // define the 1st line
  var valueline = d3.line()
    .x(function(d) { return x(d.fecha); })
    .y(function(d) { return y(d.F); });

  // define the 2nd line
  var valueline2 = d3.line()
    .x(function(d) { return x(d.fecha); })
    .y(function(d) { return y(d.M); });

  var valueline3 = d3.line()
    .x(function(d) { return x(d.fecha); })
    .y(function(d) { return y(d.S); });


  // append the svg obgect to the body of the page
  // appends a 'group' element to 'svg'
  // moves the 'group' element to the top left margin
  var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform",
      "translate(" + margin.left + "," + margin.top + ")");

  // Get the data
  d3.csv("serie-sexonac.csv", function(error, data1) {
    if (error) throw error;

    data2 = {}
    // format the data
    data1.forEach(function(d) {
      if (typeof data2[d.fecha] == 'undefined') {
        data2[d.fecha] = {F: 0, M: 0, S: 0}
      }
      data2[d.fecha][d.sexonac] += +d.freq
    })
    data = []
    Object.keys(data2).sort().forEach(function(f) {
      fecha = parseTime(f)
      data.push({fecha: fecha, F: data2[f]['F'], M: data2[f]['M'], S: data2[f]['S']})
    })

  // Scale the range of the data
  x.domain(d3.extent(data, function(d) { return d.fecha; }));
  y.domain([0, d3.max(data, function(d) {
   return Math.max(d.F, d.M, d.S); })]);

  // Add the valueline path.
  svg.append("path")
      .data([data])
      .attr("class", "line")
      .style("stroke", "red")
      .attr("d", valueline);

  // Add the valueline2 path.
  svg.append("path")
      .data([data])
      .attr("class", "line")
      .style("stroke", "green")
      .attr("d", valueline2);

  svg.append("path")
      .data([data])
      .attr("class", "line")
      .style("stroke", "blue")
      .attr("d", valueline3);


  // Add the X Axis
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // Add the Y Axis
  svg.append("g")
      .call(d3.axisLeft(y));

  });

}

export default d3_serietiempo_vs;
