# frozen_string_literal: true
json.caso do
  json.id @caso.id
  json.titulo @caso.titulo if @caso.titulo
  json.hechos @caso.memo if @caso.memo
  json.fecha @caso.fecha if @caso.fecha
  json.hora @caso.hora if @caso.hora
  if @caso.ubicacion_id
    ub = Sip::Ubicacion.find(@caso.ubicacion_id)
    json.departamento ub.departamento.nombre if ub.departamento
    json.municipio ub.municipio.nombre if ub.municipio
    json.centro_poblado ub.clase.nombre if ub.clase
    if ub.id_tsitio == 3
      json.lugar ub.lugar if ub.lugar
    end
  end
  json.presponsables do
    @caso.presponsable.each do |pr|
      json.set! pr.id, pr.nombre if pr.id && pr.nombre
    end
  end
  json.victimas do
    @caso.victima.each do |v|
      json.set! v.persona.id, v.persona.nombres + ' ' + v.persona.apellidos if v.persona
    end
  end
  anexos_fotos = @caso.anexo_caso.where(tipoanexo_id: 2).pluck(:id_anexo)
  json.fotos_victimas do 
    anexos_fotos.each do |anexo|
      json.set! anexo.to_s, sip.descarga_anexo_path(anexo.to_s) 
    end
  end
end
