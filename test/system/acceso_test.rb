# encoding: UTF-8

require 'application_system_test_case'

class AccesoTest <  ApplicationSystemTestCase

  test "control de acceso" do
    @usuario = Usuario.find_by(nusuario: 'sivel2')
    @usuario.password = 'sivel2'
    visit File.join(Rails.configuration.relative_url_root, '/usuarios/sign_in')
    fill_in "Usuario", with: @usuario.nusuario
    fill_in "Clave", with: @usuario.password
    click_button "Iniciar Sesión"
    assert page.has_content?("Administrar")

    visit File.join(Rails.configuration.relative_url_root, '/casos/nuevo')
    @numcaso=find_field('Caso No').value

    # Datos básicos
    fill_in "Fecha del hecho", with: '05/Ago/2014'
    fill_in "Título", with: 'titulo'
    click_button "Validar y Guardar"
    assert page.has_content?("05/ago/2014")

    # Solicitante Principal
    click_on "Editar"
    fill_in "Hora", with: '3:00 PM'
    fill_in "Duración", with: '2'
    click_button "Validar y Guardar"
    assert page.has_content?("05/ago/2014") 
    # puts page.body
    # Driver no acepta: accept_confirm do click_on "Eliminar" end
    #expect(page).to have_content("Casos")
  end

end

