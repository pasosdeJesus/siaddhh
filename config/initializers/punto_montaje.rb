Sivel2::Application.config.relative_url_root = ENV.fetch(
  'RUTA_RELATIVA', 'somosdefensores/siaddhh')
Sivel2::Application.config.assets.prefix = ENV.fetch(
  'RUTA_RELATIVA', 'somosdefensores/siaddhh') + '/assets'

