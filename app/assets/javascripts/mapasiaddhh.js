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
