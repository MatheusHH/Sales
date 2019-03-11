class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.order(:id).page(params['page']).per(5)
    if params[:search] != ""
      @pedidos = Pedido.search(params[:search]).page(params['page']).per(5)
    else
      @pedidos = Pedido.all.page(params['page']).per(5)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
    @pedido = Pedido.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PedidoPdf.new(@pedido, view_context)
        send_data pdf.render, 
                  filename: "pedido_.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)

    respond_to do |format|
      if @pedido.save
        format.html { redirect_to @pedido, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        format.html { redirect_to @pedido, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @pedido }
      else
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      if @pedido.vendas.size > 0 or @pedido.recebimentos.size > 0
        format.html { redirect_to pedidos_url, danger: 'Imposivel excluir este pedido.' }
        format.json { head :no_content }
      else
        format.html { redirect_to pedidos_url, notice: t('.apagado') }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:cliente_id, :observacao, vendas_attributes: [:id, :produto_id, :vendedor_id, :modalidade_id, :quantidade, :valortotal, :valortarifa, :valoreceber, :valorcomissao,  :_destroy],
      recebimentos_attributes: [:id, :vencimento, :pagamento, :valor, :_destroy]) 
    end
end
