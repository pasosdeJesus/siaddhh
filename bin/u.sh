#!/bin/sh
# Inicia produccion


if (test "${DIRAP}" = "") then {
	echo "Definir directorio de la aplicación en DIRAP"
	exit 1;
} fi;
if (test -f $DIRAP/.env) then {
	. $DIRAP/.env
} fi;
if (test "${SECRET_KEY_BASE}" = "") then {
	echo "Definir variable de ambiente SECRET_KEY_BASE"
	exit 1;
} fi;
if (test "${USUARIO_AP}" = "") then {
	echo "Definir usuario con el que se ejecuta en USUARIO_AP"
	exit 1;
} fi;
if (test "${CONFIG_HOSTS}" = "") then {
	echo "Definir config.hosts en CONFIG_HOSTS"
	exit 1;
} fi;

#if (test "${RAILS_RELATIVE_URL_ROOT}" = "") then {
#	echo "Definir ruta relativa en URL en RAILS_RELATIVE_URL_ROOT"
#	exit 1;
#} fi;

DOAS=`which doas 2> /dev/null`
if (test "$?" != "0") then {
	DOAS="sudo"
} fi;
$DOAS su - ${USUARIO_AP} -c "cd $DIRAP; rm -rf public/packs/*; NODE_ENV=production RAILS_ENV=production bin/rails assets:precompile --trace"
$DOAS su ${USUARIO_AP} -c "cd $DIRAP; RAILS_ENV=production bin/rails sip:indices"
$DOAS su ${USUARIO_AP} -c "cd $DIRAP; echo \"Iniciando unicorn...\"; CONFIG_HOSTS=${CONFIG_HOSTS} RAILS_ENV=production SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec unicorn_rails -c $DIRAP/config/unicorn.conf.minimal.rb  -E production -D"


  

