/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log('Hola Mundo desde Webpacker')

require('@rails/ujs').start()   // Javascript no intrusivo segun rails
require('turbolinks').start()   // Acelera carga de paginas

import {$, jQuery} from 'jquery';
import 'popper.js'              // Dialogos emergentes usados por bootstrap
import 'bootstrap'              // Maquetacion y elementos de diseño
import 'chosen-js/chosen.jquery';       // Cuadros de seleccion potenciados
import 'bootstrap-datepicker'
import 'bootstrap-datepicker/dist/locales/bootstrap-datepicker.es.min.js'
import 'jquery-ui'
import 'jquery-ui/ui/widgets/autocomplete'
import 'jquery-ui/ui/data'
import 'jquery-ui/ui/focusable'

var L = require('leaflet');
var mc= require('leaflet.markercluster');

//import * as d3 from 'd3'

//let d3 = require('d3')
//window.d3 = d3

import d3_serietimpo_vs from '../d3_vs'
import plotly_serietiempo_vs from '../plotly_vs'
import chartjs_serietiempo_vs from '../chartjs_vs'

document.addEventListener("DOMContentLoaded", function() {

  var p = new URL(document.URL).pathname.split('/')
  var p2ult = ''
  if (p.length>2) { 
    p2ult = p[p.length - 2] + "/" + p[p.length - 1]
  }
  console.log("p2ult=" + p2ult)
//  if (document.getElementById('div_serietiempo')) {
  if (p2ult == 'graficarjs/d3_victimizaciones_por_sexo') {
    d3_serietiempo_vs() 
  } else if (p2ult == 'graficarjs/plotly_victimizaciones_por_sexo') {
    plotly_serietiempo_vs() 
  } else if (p2ult == 'graficarjs/chartjs_victimizaciones_por_sexo') {
    chartjs_serietiempo_vs() 
  }

});

