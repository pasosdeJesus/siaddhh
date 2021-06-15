# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/motor
#//= require mr519_gen/motor
#//= require heb412_gen/motor
#//= require cocoon

@DEP_VICTIMACOLECTIVA = [
    'select[id^=caso_victima_attributes][id$=_orgsocial_id]',
  ]

@sivel2sd_actualiza_victimacolectiva = (e, victimacolectiva) ->
  sip_actualiza_cuadros_seleccion_dependientes('victimacolectiva', 
    '_orgsocial_attributes_id', '_grupoper_attributes_nombre', 
    DEP_VICTIMACOLECTIVA, true)


@sivel2sd_actualiza_victima = (e, victima) ->
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

@sivel2sd_prepara_eventos_unicos = (root, opciones = {}) ->
  sip_arregla_puntomontaje(root)
  sivel2_gen_prepara_eventos_unicos(root)

  # Propagar cambios a victimacolectiva
  $(document).on('change', 
    '#victimascolectivas [id$=_grupoper_attributes_nombre]', 
    sivel2sd_actualiza_victimacolectiva)
  
  $(document).on('cocoon:after-remove', 
    '#victimascolectivas', 
    sivel2sd_actualiza_victimacolectiva)
  
  $(document).on('cocoon:after-insert', 
    '#victimascolectivas', 
    sivel2sd_actualiza_victimacolectiva)
  
  $(document).on('cocoon:before-remove', '#victimascolectivas', (e, vc) ->
    return sip_intenta_eliminar_fila(vc, '/victimascolectivas/', 
      DEP_VICTIMACOLECTIVA)
  )

  $(document).on('cocoon:after-insert', '#victimas', 
    sivel2sd_actualiza_victimacolectiva)

  $(document).on('sip:autocompleto_grupoper', 
    sivel2sd_actualiza_victimacolectiva)


  # Propagar cambios a victima
  $(document).on('change', 
    '#victimas [id$=_persona_attributes_nombres]', 
    sivel2sd_actualiza_victima)

  $(document).on('change', 
    '#victimas [id$=_persona_attributes_apellidos]', 
    sivel2sd_actualiza_victima)

  $(document).on('change', 
    '#victimas [id$=_persona_attributes_orgsocial_persona_attributes_orgsocial_id]', 
    sivel2sd_actualiza_victima)
  
  $(document).on('change', 
    '#victimas [id$=_persona_attributes_orgsocial_persona_attributes_perfilorgsocial_id]', 
    sivel2sd_actualiza_victima)

  $(document).on('cocoon:after-remove', 
    '#victimas', 
    sivel2sd_actualiza_victima)
  
  $(document).on('cocoon:after-insert', 
    '#victimas', 
    sivel2sd_actualiza_victima)
 
  $(document).on('cocoon:after-insert', '#victimascolectivas', 
    sivel2sd_actualiza_victima)

  $(document).on('sip:autocompleto_persona', 
    sivel2sd_actualiza_victima)


 
  # Si se agrega con cocoon un campo de seleccion que se espera con
  # chosen, usa chosen
  $(document).on('cocoon:after-insert', '', (e,inserted) ->
    inserted.find('select[class*=chosen-select]').chosen()
  )

  return

