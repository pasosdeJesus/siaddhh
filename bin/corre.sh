#!/bin/sh
# Inicia servicio

if (test -f ".env") then {
	. .env
} fi;
if (test "$RC" = "") then {
	RC=sivel2
} fi;
echo "RAILS_ENV=$RAILS_ENV"
echo "PUERTODES=$PUERTODES"

if (test "$SININD" != "1") then {
	bin/rails sip:indices RALS_ENV=$RAILS_ENV
} fi;

if (test "$RAILS_ENV" = "development") then {
	bin/rails s -p $PUERTODES -b 0.0.0.0
} else {
	if (test ! -f /etc/rc.d/$RC) then {
		echo "Falta script /etc/rc.d/$RC"
		exit 1;
	} fi;
	doas sh /etc/rc.d/$RC -d start
} fi;


