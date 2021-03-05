Sivel2::Application.config.relative_url_root = ENV.fetch(
  'RUTA_RELATIVA', 'somosdefensores/sivel2')
Sivel2::Application.config.assets.prefix = ENV.fetch(
  'RUTA_RELATIVA', 'somosdefensores/sivel2') + '/assets'

