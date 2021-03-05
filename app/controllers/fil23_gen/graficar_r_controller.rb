# Grafica con R

module Fil23Gen
  class GraficarRController < ApplicationController

    # Si hace falta arranca aplicación shiny
    def arranca_ap_shiny
      # Como una aplicación shiny puede responder a diversos usuarios
      # lo que hacemos por ahora es lanzar una que atienda a todos sobre
      # un proceso nuevo que no bloquee la aplicación rails.
      # Solo vuelve a iniciarse si un usuario solicita la gráfica
      # y se detecta que no está operando
      # Esto no resuelve autenticación, pues cualquie usuario podría
      # verla corriendo si adivina el puerto.  Pero es un avance, para
      # autenticación tal vez podría implementarse entre otros con
      # datos de sesión que parece shiny puede usar.

      ult_numproc = -1
      pact = [] # Proceso ruby donde se corrió R y que sigue activo
      lproc = Sip::ProcesosHelper.procesos_OpenBSD
      # En modo desarrollo, usando puma la estructura de procesos cuando no se ha ejecutado shiny es:
      # - bin/corre.sh
      #   |- ruby: puma 4.3.5 (ssl://...) [sivel2_somosdefensores] (ruby27)
      #      |- /usr/local/lib/R/bin/exec/R --interactive --slave
      #
      # Y una vez se ejecuta shiny en un proceso hijo (eliminando la instancia inicial de R e iniciando una en el proceso hijo):
      # - bin/corre.sh
      #   |- ruby: puma 4.3.5 (ssl://...) [sivel2_somosdefensores] (ruby27)
      #     |- ruby: puma 4.3.5 (ssl://...) [sivel2_somosdefensores] (ruby27)
      #        |- /usr/local/lib/R/bin/exec/R --interactive --slave
      # - sh -c /usr/local/bin/xdg-open "http://1...:2902" > /dev/null 2>&1 || /usr/local/bin/xdg-open "http://192.168.77.78:2902" &
      #   |- /bin/sh /usr/local/bin/xdg-open http://1...:2902"
      #     |- chrome: --disable-features=WebAssembly,AsmJsToWebAssembly,WebAssemblyStreaming --js-flags=--noexpose-wasm http://1...:2902 (chrome)
      #     |- /bin/sh /usr/local/bin/xdg-settings check default-web-browser chromium-browser.desktop
      #     |- /bin/sh /usr/local/bin/xdg-settings check default-web-browser chromium-browser.desktop
      #     |- /bin/sh /usr/local/bin/xdg-mime query default x-scheme-handler/http
      #     |- xprop -root
      #     |- grep -i ^xfce_desktop_window
      #
      # Y una vez se cierra el chrome que intenta abrir queda:
      #  - /bin/sh bin/corre.sh
      #    |- ruby: puma 4.3.5 (ssl://1...) [sivel2_somosdefensores] (ruby27)
      #       |- ruby: puma 4.3.5 (ssl://1...) [sivel2_somosdefensores] (ruby27)
      #         |- /usr/local/lib/R/bin/exec/R --interactive --slave
      #
      # Y en modo producción con Unicorn cuando no ha ejecutado shiny:
      #
      #  - ruby27: unicorn_rails master -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #   |- ruby27: unicorn_rails worker[1] -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #     |- /usr/local/lib/R/bin/exec/R --interactive --slave
      #   |- ruby27: unicorn_rails worker[0] -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #     |- /usr/local/lib/R/bin/exec/R --interactive --slave
      #
      #  Cuando ejecuta shiny:
      #
      #  - ruby27: unicorn_rails master -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #   |- ruby27: unicorn_rails worker[1] -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #     |- ruby27: unicorn_rails worker[1] -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #       |- /usr/local/lib/R/bin/exec/R --interactive --slave
      #   |- ruby27: unicorn_rails worker[0] -c /var/www/htdocs/sivel2_somosdefensores/config/unicorn.conf.minimal.rb -E production -D (ruby27)
      #     |- /usr/local/lib/R/bin/exec/R --interactive --slave
      
      # En todos los casos los proceso comparten el mismo gpid
      #
      # El caso de unicorn muestra que la forma en la que estabamos
      # manejandolo no prospera, porque replica creación de proceso 
      # R por cada trabajador de unicorn.  
      # En realidad basta uno, porque todos los trabajadores pueden
      # dirigir al mismo puerto.
      #
      # Hemos notado que en ocasiones queda el proceso R pero no el
      # trbajador, y en ocasiones queda el trabajador pero no el maestro.
      # Incluso arrancando de nuevo el maestro.
      # En ocasiones responde por el puerto pero con un mensaje de error.
      #
      # Nos parece mejor detectar si el puerto reservado ya está bajo el 
      # control de un proceso con el gpid del trabajador que corre y en caso
      # afirmativo verificar que responda shiny.  Si no se cumple alguna
      # de estas condiciones, mejor matar el proceso que corre en 
      # el puerto reservado y volver a iniciar R y shiny.
      
      ini = true # Inicializar R con shiny  
      miproc = Process.pid 
      puts "miproc=#{miproc}"
      dmiproc = lproc.select{|p| p[:pid].to_i == miproc}[0]
      puts "dmiproc=#{dmiproc}"
      fspuerto = `fstat | grep :#{@fil23_gen_op[:puerto]}$`.split(" ")
      puts "fspuerto=#{fspuerto}"
      if fspuerto.length != 0
        # Verificamos si el proceso que maneja puerto reservado para shiny
        # está en el mismo grupo de este proceso
        ppuerto = fspuerto[2].to_i
        puts "ppuerto=#{ppuerto}"
        puts "lproc=#{lproc}"
        dppuerto = lproc.select{|p| p[:pid].to_i == ppuerto}[0]
        puts "dppuerto=#{dppuerto}"
        if dppuerto[:ppid] != dmiproc[:ppid]
          Process.kill("KILL", ppuerto)
        else
          # Verificamos que la aplicación que corre en el puerto reservado
          # esté respondiedo los esperado
          res = ''
          open("http://#{@fil23_gen_op[:ip]}:#{@fil23_gen_op[:puerto]}") {|f|
                f.each_line {|line| res << line + "\n"}
          } 
          if !res.include?('shiny')
            Process.kill("KILL", ppuerto)
            ini = true
          else
            ini = false
          end
        end
      end
      if ini
      #if Fil23Gen::Bifurcacion.all.count > 0
      #  ult_numproc = Fil23Gen::Bifurcacion.order(:marcatemporal).last.numproc
      #  pact = lproc.select{|p| p[:pid].to_i == ult_numproc} #&&
      #                      #/\/R /.match(p[:command]) }
      #end
      #if pact.count == 0
        begin
          ::R.quit
        rescue
          puts "::R.quit no funcionó (tal vez ya se había ejecutado)"
        end
        numproc = fork {
          # No usamo aqui ::R porque notamos que puede usar un proceso
          # de R pegado al proceso principal de ruby asi que bloquea
          # la aplicación completa
          miR = RinRuby.new
          miR.eval <<-EOF
            print("Iniciando aplicacion R")
            write(getwd(), stdout())
            rutacsv="#{@fil23_gen_op[:rutacsv]}"
            source("#{@fil23_gen_op[:guionR]}")
          EOF
          #      byebug
          miR.eval <<-EOF
            shinyApp(ui = interfaz, server = servidor, 
            options = list(host = "#{@fil23_gen_op[:ip]}", 
            port = #{@fil23_gen_op[:puerto]}))
          EOF
          return false # hijo no necesita hacer render
        }
        if numproc > 0 
          # Fil23Gen::Bifurcacion.create(numproc: numproc,
          #   marcatemporal: Time.now)
          sleep 3 # Damos tiempo a aplicacion shiny de arranca antes de continuar presentando iframe
        else
          puts "No pudo bifurcarse proceso"
          render inline: 'No pudo bifurcarse proceso para shiny', 
            layout: 'application'
          return false
        end
      else
        puts "Ya existe proceso #{dppuerto[:pid]} con estado #{dppuerto[0][:stat]}"
      end

      return true
    end

    def victimizaciones_individuales
      authorize! :contar, Sivel2Gen::Caso

      @rutacsv = File.join(Rails.root, 'public/somosdefensores/sivel2/csv/victimizaciones_individuales.csv').to_s

      tarc = Tempfile.new(['victimizaciones_individuales', '.csv'], '/var/www/tmp/')
      rutatmp = tarc.path
      tarc.close
      tarc.unlink
      sql = "COPY (SELECT DISTINCT acto.id_caso AS caso_id, " \
        "caso.fecha, " \
        "supracategoria.id_tviolencia AS tviolencia_id," \
        "categoria.id AS categoria_id, " \
        "categoria.nombre AS categoria_nombre, " \
        "supracategoria.id_tviolencia || categoria.id || ' ' || categoria.nombre AS categoria_rotulo, " \
        "acto.id_persona AS persona_id, " \
        "persona.sexo AS sexonac, " \
        "ubicacion.id_departamento AS departamento_id, " \
        "departamento.nombre AS departamento, " \
        "ubicacion.id_municipio AS municipio_id " \
        "FROM  sivel2_gen_acto AS acto " \
        "JOIN sivel2_gen_caso AS caso ON caso.id = acto.id_caso " \
        "JOIN sivel2_gen_categoria AS categoria ON categoria.id=acto.id_categoria " \
        "JOIN sivel2_gen_supracategoria AS supracategoria ON supracategoria.id = categoria.supracategoria_id " \
        "JOIN sip_persona AS persona ON persona.id = acto.id_persona " \
        "JOIN sivel2_gen_victima AS victima ON " \
        "  victima.id_caso=acto.id_caso AND " \
        "  victima.id_persona=acto.id_persona " \
        "LEFT JOIN sip_ubicacion AS ubicacion ON ubicacion.id=caso.ubicacion_id " \
        "LEFT JOIN sip_departamento AS departamento ON ubicacion.id_departamento=departamento.id " \
        ") TO '#{rutatmp}' DELIMITER ',' CSV HEADER;" 
      res = ActiveRecord::Base.connection.execute(sql)
      if File.exist?(@rutacsv)
        File.unlink(@rutacsv)
      end
      FileUtils.cp(rutatmp, @rutacsv)
      if ENV['fil23_gen_servidor'].nil?
        flash[:error] = "No se ha definidio fil23_gen_servidor"
        redirect_to Rails.configuration.relative_url_root
        return
      end
      @fil23_gen_op = {
        servidor: ENV['fil23_gen_servidor'],
        ip: ENV['fil23_gen_ip'],
        puerto: ENV['fil23_gen_puerto'],
        protocolo: ENV['fil23_gen_protocolo'],
        guionR: 'lib/R/victimizaciones_individuales.R',
        rutacsv: @rutacsv
      }

      if arranca_ap_shiny #@fil23_gen_op
        render 'fil23_gen/graficar_r/graficar', layout: 'application'
      end
    end

  end

end
