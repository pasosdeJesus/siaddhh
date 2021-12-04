# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/motor
#//= require mr519_gen/motor
#//= require heb412_gen/motor
#//= require cocoon

@DEP_VICTIMACOLECTIVA = [
    'select[id^=caso_victima_attributes][id$=_orgsocial_id]',
  ]

@siaddhh_actualiza_victimacolectiva = (e, victimacolectiva) ->
  sip_actualiza_cuadros_seleccion_dependientes('victimacolectiva', 
    '_orgsocial_attributes_id', '_grupoper_attributes_nombre', 
    DEP_VICTIMACOLECTIVA, true)


@siaddhh_actualiza_victima = (e, victima) ->
  tabla = {}
  lobj = $('#victimas .nested-fields[style!="display: none;"]')
  lobj.each((k, v) ->
    orgsocial_id = $(v).find('select[id$=_persona_attributes_orgsocial_persona_attributes_orgsocial_id]').val()
    pas_id = $(v).find('select[id$=_persona_attributes_orgsocial_persona_attributes_perfilorgsocial_id]').val()
    epas_id = $(v).find('select[id$=_persona_attributes_orgsocial_persona_attributes_perfilorgsocial_id]').attr('id')
    nom = $(v).find('input[id$=_persona_attributes_nombres]').val() 
    ape = $(v).find('input[id$=_persona_attributes_apellidos]').val() 
    perfil = ''
    if pas_id != ''
      perfil = $('#' + epas_id + '> option[value=' + pas_id + ']').html() 
    f = '<tr><td>' + nom + '</td>' +
      '<td>' + ape + '</td>' + 
      '<td>' + perfil + '</td></tr>'
    if typeof tabla[orgsocial_id] == 'undefined'
      tabla[orgsocial_id] = f
    else
      tabla[orgsocial_id] += f
  )
  for k,v of tabla
    $('#tabla_victima_orgsocial_' + k + ' tbody').html(v)

@siaddhh_prepara_eventos_unicos = (root, opciones = {}) ->
  sip_arregla_puntomontaje(root)
  sivel2_gen_prepara_eventos_unicos(root)

  # Propagar cambios a victimacolectiva
  $(document).on('change', 
    '#victimascolectivas [id$=_grupoper_attributes_nombre]', 
    siaddhh_actualiza_victimacolectiva)
  
  $(document).on('cocoon:after-remove', 
    '#victimascolectivas', 
    siaddhh_actualiza_victimacolectiva)
  
  $(document).on('cocoon:after-insert', 
    '#victimascolectivas', 
    siaddhh_actualiza_victimacolectiva)
  
  $(document).on('cocoon:before-remove', '#victimascolectivas', (e, vc) ->
    return sip_intenta_eliminar_fila(vc, '/victimascolectivas/', 
      DEP_VICTIMACOLECTIVA)
  )

  $(document).on('cocoon:after-insert', '#victimas', 
    siaddhh_actualiza_victimacolectiva)

  $(document).on('sip:autocompleto_grupoper', 
    siaddhh_actualiza_victimacolectiva)


  # Propagar cambios a victima
  $(document).on('change', 
    '#victimas [id$=_persona_attributes_nombres]', 
    siaddhh_actualiza_victima)

  $(document).on('change', 
    '#victimas [id$=_persona_attributes_apellidos]', 
    siaddhh_actualiza_victima)

  $(document).on('change', 
    '#victimas [id$=_persona_attributes_orgsocial_persona_attributes_orgsocial_id]', 
    siaddhh_actualiza_victima)
  
  $(document).on('change', 
    '#victimas [id$=_persona_attributes_orgsocial_persona_attributes_perfilorgsocial_id]', 
    siaddhh_actualiza_victima)

  $(document).on('cocoon:after-remove', 
    '#victimas', 
    siaddhh_actualiza_victima)
  
  $(document).on('cocoon:after-insert', 
    '#victimas', 
    siaddhh_actualiza_victima)
 
  $(document).on('cocoon:after-insert', '#victimascolectivas', 
    siaddhh_actualiza_victima)

  $(document).on('sip:autocompleto_persona', 
    siaddhh_actualiza_victima)


 
  # Si se agrega con cocoon un campo de seleccion que se espera con
  # chosen, usa chosen
  $(document).on('cocoon:after-insert', '', (e,inserted) ->
    inserted.find('select[class*=chosen-select]').chosen()
  )

  mtc = $("input[name='filtro[mostrar_cats]']")
  mtc.change ->
    if($(this).val() == "1")
      $('#filtro_categoria option').prop('selected', true);
      $("#filtro_categoria").trigger('chosen:updated')
    if($(this).val() == "0")
      $("#filtro_categoria :selected").prop("selected", false); 
      $("#filtro_categoria").trigger('chosen:updated')

  fcat = $("#filtro_categoria")
  fcat.change ->
    alguno = $("#filtro_mostrar_cats_2")
    ninguno = $("#filtro_mostrar_cats_0")
    op_totales = this.options.length
    op_sel = $(this).val().length
    if(op_sel > 0)
      alguno.prop("checked", true);
    else
      ninguno.prop("checked", true);


  ftv = $("#filtro_tviolencia_id")
  ftv.change ->
    fc = $("#filtro_categoria")
    cats = fc.html()
    tviolencia = $("#filtro_tviolencia_id :selected").text()
    filtro = "optgroup[label='".concat(tviolencia).concat("']")
    $("#filtro_categoria :selected").prop("selected", false); 
    fc.trigger('chosen:updated')
    $sel = $('select[name="filtro[categoria][]"]')
    val = $(this).val()
    $('span > optgroup', $sel).unwrap()
    if (val != "")
      $('optgroup:not([label="' + tviolencia + '"])', $sel).wrap('<span/>');
      fc.trigger('chosen:updated')
      $('#filtro_categoria option').prop('selected', true);
      fc.trigger('chosen:updated')
    else
      fc.html(cats)
      fc.trigger('chosen:updated')

  return

