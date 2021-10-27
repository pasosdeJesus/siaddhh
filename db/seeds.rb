conexion = ActiveRecord::Base.connection();

# De motores y finalmente de este
motor = ['sip', 'sivel2_gen', nil]
motor.each do |m|
    Sip::carga_semillas_sql(conexion, m, :cambios)
    Sip::carga_semillas_sql(conexion, m, :datos)
end

# usuario siaddhh con clave siaddhh
conexion.execute("INSERT INTO public.usuario 
	(nusuario, email, encrypted_password, password, 
  fechacreacion, created_at, updated_at, rol) 
	VALUES ('siaddhh', 'siaddhh@localhost', 
  '$2a$10$xHJyvwO6lA162lyMWfTGEeAkjMgE67gISvJi2aKYq8aoIcJEBEgN.',
	'', '2014-08-26', '2014-08-26', '2014-08-26', 1);")

