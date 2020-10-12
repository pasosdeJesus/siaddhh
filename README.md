# SIADDHH


[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) [![Estado Construcción](https://api.travis-ci.org/pasosdeJesus/sivel2_somosdefensores.svg?branch=master)](https://travis-ci.org/pasosdeJesus/sivel2_somosdefensores) [![Clima del Código](https://codeclimate.com/github/pasosdeJesus/sivel2_somosdefensores/badges/gpa.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_somosdefensores) [![Cobertura de Pruebas](https://codeclimate.com/github/pasosdeJesus/sivel2_somosdefensores/badges/coverage.svg)](https://codeclimate.com/github/pasosdeJesus/sivel2_somosdefensores) [![security](https://hakiri.io/github/pasosdeJesus/sivel2_somosdefensores/master.svg)](https://hakiri.io/github/pasosdeJesus/sivel2_somosdefensores/master)

![Logo de sivel2](https://raw.githubusercontent.com/pasosdeJesus/sivel2/master/public/images/logo.jpg)


Ver instrucciones en <https://github.com/pasosdeJesus/sivel2>

# Producción


El script por ubicar en /etc/rc.d/s:

```
#!/bin/sh
servicio="CONFIG_HOSTS=miservidor.org PUERTOUNICORN=2022 DIRAP=/var/www/htdocs/sivel2_somosdefensores URLBASE=/somosdefensores/sivel2/ USUARIO_AP=miusuario SECRET_KEY_BASE=df /var/www/htdocs/sivel2_somosdefensores/bin/u.sh"

. /etc/rc.d/rc.subr

rc_check() {
        ps axw | grep "[r]uby.*unicorn_rails.*sivel2_somosdefensores/" > /dev/null
}

rc_stop() {
        p=`ps axw | grep "[r]uby.*unicorn_rails.*master.*sivel2_somosdefensores/" | sed -e "s/^ *\([0-9]*\) .*/\1/g"`
	if (test "$p" = "") then {
		# Matamos proceso hijo si quedo por ahi
		p=`ps axw | grep "[r]uby.*unicorn_rails.*worker.*sivel2_somosdefensores/" | sed -e "s/^ *\([0-9]*\) .*/\1/g"`;
	} fi;
	if (test "$p" != "") then {
		kill $p;
	} fi;
}

rc_cmd $1
```

En `/etc/nginx/nginx.conf` además de la configuración tipica:

```
        location ^~ /somosdefensores/sivel2/conteos/ {
                gzip_static on;
                add_header Cache-Control public;
                root /var/www/htdocs/sivel2_somosdefensores/public/;
        }
```


