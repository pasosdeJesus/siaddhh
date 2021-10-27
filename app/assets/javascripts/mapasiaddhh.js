function filtrar_por_categoria(usuario_autenticado){
  filtro_cat = ''
  if (!usuario_autenticado){
    // Categorias que sean perder la vida 
    cats = [10, 20, 30, 40, 50, 87, 97, 701, 703];
    cats.forEach(elem => 
      filtro_cat += '&filtro[categoria_id][]=' + elem
    );
  }
  return filtro_cat
}

function obtener_info_victimas(victimas, prresp, caso){
  ruta_foto = caso.fotos_victimas;
  var victimasCont = '<div>' 
  if(ruta_foto){
    for(var rf in ruta_foto){
      victimasCont += '<img class="m-3" src="'+ ruta_foto[rf] +'" style="height:7vw;width:4vw;">'
    }
  }
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
