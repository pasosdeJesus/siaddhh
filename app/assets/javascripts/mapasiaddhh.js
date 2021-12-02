function filtrar_adicionales(usuario_autenticado){
  filtros_adicionales = []

  // filtrar por categoria de vida si es consulta publica
  filtro_cat = ''
  if (!usuario_autenticado){
    // Categorias que sean perder la vida 
    cats = [10, 20, 30, 40, 50, 87, 97, 701, 703];
    cats.forEach(elem => 
      filtro_cat += '&filtro[categoria_id][]=' + elem
    );
  }
  filtros_adicionales.push(filtro_cat)

  //Filtrar por profesion/liderazgo
  filtro_lid = ''
  var tliderazgo = $('#tliderazgo').val();
  for(var tl in tliderazgo){
    if (tliderazgo != undefined && tliderazgo != 0){
      filtro_lid += '&filtro[profesion_id][]=' + tliderazgo[tl];
    }
  }
  filtros_adicionales.push(filtro_lid)
  return filtros_adicionales;
}

function obtener_info_victimas(victimas, prresp, caso){
  ruta_foto = caso.fotos_victimas;
  var victimasCont = '<div class="text-center">'
  if(ruta_foto){
    primera = jQuery.map(ruta_foto, function(n, i ){return n })[0]
    victimasCont += '<img class="m-3 img-fluid" src="'+ primera +'" style="max-height: 45vh; width: 35vh">'

  }
  victimasCont += '</div>' 
  victimasCont += '<table>' +
  '<tr><td>Victimas:</td><td>';
  for(var cv in victimas) {
    var victima = victimas[cv];
    victimasCont += ((typeof victima != 'undefined') && 
      victima != "") ? victima + '<br />' : 'SIN INFORMACIÓN';
  }
  victimasCont += '</td></tr><tr>' +
    '<td>Presuntos Responsables:</td><td>';
  for(var cp in prresp) {
    var prrespel = prresp[cp];
    victimasCont += ((typeof prrespel != 'undefined') && prrespel != "") ? 
      prrespel + '<br />' : 'SIN INFORMACIÓN';
  }
  victimasCont += '</td></tr></table></div>';
  return victimasCont
}


function siaddhh_DescargarCasosOsm(autenticado) {
  var root = window;
  if (typeof root.formato_fecha == 'undefined') {
    sip_prepara_eventos_comunes(root)
  }
  url = armarRutaConsulta(root, 'casos.csv', false)

  // Método para descargar de
  // https://stackoverflow.com/questions/3749231/download-file-using-javascript-jquery
  var enlace= document.createElement("a");
  enlace.setAttribute('download', 'casos-somosdefensores.csv');
  enlace.href = url;
  document.body.appendChild(enlace);
  enlace.click();
  enlace.remove();
}
