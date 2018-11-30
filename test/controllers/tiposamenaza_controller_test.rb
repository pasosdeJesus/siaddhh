require 'test_helper'

class TiposamenazaControllerTest < ActionController::TestCase
  setup do
    skip
    @tipoamenaza = Tipoamenaza(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoamenaza)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create tipoamenaza" do
    skip
    assert_difference('Tipoamenaza.count') do
      post :create, tipoamenaza: { created_at: @tipoamenaza.created_at, fechacreacion: @tipoamenaza.fechacreacion, fechadeshabilitacion: @tipoamenaza.fechadeshabilitacion, nombre: @tipoamenaza.nombre, observaciones: @tipoamenaza.observaciones, updated_at: @tipoamenaza.updated_at }
    end

    assert_redirected_to tipoamenaza_path(assigns(:tipoamenaza))
  end

  test "should show tipoamenaza" do
    skip
    get :show, id: @tipoamenaza
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @tipoamenaza
    assert_response :success
  end

  test "should update tipoamenaza" do
    skip
    patch :update, id: @tipoamenaza, tipoamenaza: { created_at: @tipoamenaza.created_at, fechacreacion: @tipoamenaza.fechacreacion, fechadeshabilitacion: @tipoamenaza.fechadeshabilitacion, nombre: @tipoamenaza.nombre, observaciones: @tipoamenaza.observaciones, updated_at: @tipoamenaza.updated_at }
    assert_redirected_to tipoamenaza_path(assigns(:tipoamenaza))
  end

  test "should destroy tipoamenaza" do
    skip
    assert_difference('Tipoamenaza.count', -1) do
      delete :destroy, id: @tipoamenaza
    end

    assert_redirected_to tiposamenaza_path
  end
end
