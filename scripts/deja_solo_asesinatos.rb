# Ejecutar con 
#bin/rails runner -e development scripts/elimina_casos_tras_fecha.rb 2020-01-01

require_relative 'auxiliar_eliminar'

eliminar_casos("SELECT id_caso FROM sivel2_gen_acto WHERE id_categoria NOT IN (10, 20, 30, 40, 50, 87, 97, 701)");

