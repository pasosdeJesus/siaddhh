require "test_helper"

class PuedeVerHogarTest < ActionDispatch::IntegrationTest

  include Capybara::DSL
  test "hogar con contenido" do 
    visit Rails.configuration.relative_url_root
    puts page.body
    assert page.has_content?("Iniciar Sesión")
  end

end
