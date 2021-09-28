#!/bin/sh
# Inicia servidor en modo produccion dentro de Jaula chroot
# Dominio publico. 2016. vtamara@pasosdeJesus.org

if (test "${SECRET_KEY_BASE}" = "") then {
	echo "Definir variable de ambiente SECRET_KEY_BASE"
	exit 1;
} fi;
if (test "${DIRAP}" = "") then {
	echo "Definir variable de ambiente DIRAP con ruta dentro de jaula"
	exit 1;
} fi;

export HOME=$DIRAP
export GEM_PATH=$GEM_PATH:$DIRAP/vendor/bundle/ruby/2.3

cd $DIRAP
if (test "${RAILS_RELATIVE_URL_ROOT}" != "") then {
	RAILS_RELATIVE_URL_ROOT=${RAILS_RELATIVE_URL_ROOT} bundle exec rake assets:precompile 
} else {
	bundle exec rake assets:precompile
} fi;

echo "Iniciando unicorn..."; 
SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec unicorn_rails -c ../siaddhh/config/unicorn.conf.minimal.rb  -E production -D


  

