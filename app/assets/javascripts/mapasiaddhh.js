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

