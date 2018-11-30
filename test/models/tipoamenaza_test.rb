# encoding: UTF-8

require 'test_helper'

class TipoamenazaTest < ActiveSupport::TestCase

  PRUEBA_TIPOAMENAZA = {
    nombre: "Tipoamenaza",
    fechacreacion: "2018-11-30",
    created_at: "2018-11-30"
  }

  test "valido" do
    Tipoamenaza = ::Tipoamenaza.create(
      PRUEBA_TIPOAMENAZA)
    assert(Tipoamenaza.valid?)
    Tipoamenaza.destroy
  end

  test "no valido" do
    Tipoamenaza = ::Tipoamenaza.new(
      PRUEBA_TIPOAMENAZA)
    Tipoamenaza.nombre = ''
    assert_not(Tipoamenaza.valid?)
    Tipoamenaza.destroy
  end

  test "existente" do
    skip
    Tipoamenaza = ::Tipoamenaza.where(id: 0).take
    assert_equal(Tipoamenaza.nombre, "SIN INFORMACIÓN")
  end

end
