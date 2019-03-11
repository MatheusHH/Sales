require 'test_helper'

class RecebimentosControllerTest < ActionController::TestCase
  setup do
    @recebimento = recebimentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recebimentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recebimento" do
    assert_difference('Recebimento.count') do
      post :create, recebimento: { pagamento: @recebimento.pagamento, pedido_id: @recebimento.pedido_id, valor: @recebimento.valor, vencimento: @recebimento.vencimento }
    end

    assert_redirected_to recebimento_path(assigns(:recebimento))
  end

  test "should show recebimento" do
    get :show, id: @recebimento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recebimento
    assert_response :success
  end

  test "should update recebimento" do
    patch :update, id: @recebimento, recebimento: { pagamento: @recebimento.pagamento, pedido_id: @recebimento.pedido_id, valor: @recebimento.valor, vencimento: @recebimento.vencimento }
    assert_redirected_to recebimento_path(assigns(:recebimento))
  end

  test "should destroy recebimento" do
    assert_difference('Recebimento.count', -1) do
      delete :destroy, id: @recebimento
    end

    assert_redirected_to recebimentos_path
  end
end
