require 'test_helper'

class ProdentradasControllerTest < ActionController::TestCase
  setup do
    @prodentrada = prodentradas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prodentradas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prodentrada" do
    assert_difference('Prodentrada.count') do
      post :create, prodentrada: { entrada_id: @prodentrada.entrada_id, produto_id: @prodentrada.produto_id, quantidade: @prodentrada.quantidade }
    end

    assert_redirected_to prodentrada_path(assigns(:prodentrada))
  end

  test "should show prodentrada" do
    get :show, id: @prodentrada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prodentrada
    assert_response :success
  end

  test "should update prodentrada" do
    patch :update, id: @prodentrada, prodentrada: { entrada_id: @prodentrada.entrada_id, produto_id: @prodentrada.produto_id, quantidade: @prodentrada.quantidade }
    assert_redirected_to prodentrada_path(assigns(:prodentrada))
  end

  test "should destroy prodentrada" do
    assert_difference('Prodentrada.count', -1) do
      delete :destroy, id: @prodentrada
    end

    assert_redirected_to prodentradas_path
  end
end
