class VendasController < ApplicationController
  before_action :set_venda, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /vendas
  # GET /vendas.json
  def index
    @vendas = Venda.order(:pedido_id).page(params['page']).per(5)
    if params[:search] != ""
      @vendas = Venda.where(pedido_id: params[:search]).page(params['page']).per(5)
    else
      if params[:datainicial] and params[:datafinal] != ""
        @vendas = Venda.search(params[:datainicial],params[:datafinal]).page(params['page']).per(5)
      else
        if params[:nomevendedor] and params[:vendadatainicial] and params[:vendadatafinal] != ""
          @vendas = Venda.searchcomissao(params[:nomevendedor],params[:vendadatainicial],params[:vendadatafinal]).page(params['page']).per(5)
        else
          @vendas = Venda.order(:pedido_id).page(params['page']).per(5)
        end
      end
    end
  end

  # GET /vendas/1
  # GET /vendas/1.json
  def show
  end

  # GET /vendas/new
  def new
    @venda = Venda.new
  end

  # GET /vendas/1/edit
  def edit
  end

  # POST /vendas
  # POST /vendas.json
  def create
    @venda = Venda.new(venda_params)

    respond_to do |format|
      if @venda.save
        format.html { redirect_to @venda, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @venda }
      else
        format.html { render :new }
        format.json { render json: @venda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendas/1
  # PATCH/PUT /vendas/1.json
  def update
    @produto = Produto.find(@venda.produto_id)
    qtdantiga = @venda.quantidade
    respond_to do |format|
      if @venda.update(venda_params)
        format.html { redirect_to @venda, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @venda }
      else
        format.html { render :edit }
        format.json { render json: @venda.errors, status: :unprocessable_entity }
      end

      if qtdantiga > @venda.quantidade
        qtd = qtdantiga - @venda.quantidade
        @produto.estoque = @produto.estoque + qtd
      else 
        if qtdantiga < @venda.quantidade
          qtd = @venda.quantidade - qtdantiga
          @produto.estoque = @produto.estoque - qtd
        end
      end
      @produto.save
    end
  end

  # DELETE /vendas/1
  # DELETE /vendas/1.json
  def destroy
    @venda.destroy
    respond_to do |format|
      format.html { redirect_to vendas_url, notice: t('.apagado') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venda
      @venda = Venda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venda_params
      params.require(:venda).permit(:pedido_id, :produto_id, :vendedor_id, :modalidade_id, :quantidade, :valortotal, :valortarifa, :valoreceber, :valorcomissao)
    end
end
