# SIADDHH


[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) [![Estado Construcción](https://gitlab.com/pasosdeJesus/siaddhh/badges/main/pipeline.svg)](https://gitlab.com/pasosdeJesus/siaddhh/-/pipelines)[![Clima del Código](https://codeclimate.com/github/pasosdeJesus/siaddhh/badges/gpa.svg)](https://codeclimate.com/github/pasosdeJesus/siaddhh) [![Cobertura de Pruebas](https://codeclimate.com/github/pasosdeJesus/siaddhh/badges/coverage.svg)](https://codeclimate.com/github/pasosdeJesus/siaddhh) [![security](https://hakiri.io/github/pasosdeJesus/siaddhh/master.svg)](https://hakiri.io/github/pasosdeJesus/siaddhh/master)

![Logo de sivel2](https://raw.githubusercontent.com/pasosdeJesus/sivel2/master/public/images/logo.jpg)


Ver instrucciones en <https://github.com/pasosdeJesus/sivel2>

# Producción


El script por ubicar en /etc/rc.d/s:

```
#!/bin/sh
servicio="CONFIG_HOSTS=miservidor.org PUERTOUNICORN=2022 DIRAP=/var/www/htdocs/siaddhh URLBASE=/somosdefensores/siaddhh/ USUARIO_AP=miusuario SECRET_KEY_BASE=df /var/www/htdocs/siaddhh/bin/u.sh"

. /etc/rc.d/rc.subr

rc_check() {
        ps axw | grep "[r]uby.*unicorn_rails.*siaddhh/" > /dev/null
}

rc_stop() {
        p=`ps axw | grep "[r]uby.*unicorn_rails.*master.*siaddhh/" | sed -e "s/^ *\([0-9]*\) .*/\1/g"`
	if (test "$p" = "") then {
		# Matamos proceso hijo si quedo por ahi
		p=`ps axw | grep "[r]uby.*unicorn_rails.*worker.*siaddhh/" | sed -e "s/^ *\([0-9]*\) .*/\1/g"`;
	} fi;
	if (test "$p" != "") then {
		kill $p;
	} fi;
}

rc_cmd $1
```

En `/etc/nginx/nginx.conf` además de la configuración tipica:

```
        location ^~ /somosdefensores/siaddhh/conteos/ {
                gzip_static on;
                add_header Cache-Control public;
                root /var/www/htdocs/siaddhh/public/;
        }
```


