class ProdentradasController < ApplicationController
  before_action :set_prodentrada, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /prodentradas
  # GET /prodentradas.json
  def index
    @prodentradas = Prodentrada.all.page(params['page']).per(5)
  end

  # GET /prodentradas/1
  # GET /prodentradas/1.json
  def show
  end

  # GET /prodentradas/new
  def new
    @prodentrada = Prodentrada.new
  end

  # GET /prodentradas/1/edit
  def edit
  end

  # POST /prodentradas
  # POST /prodentradas.json
  def create
    @prodentrada = Prodentrada.new(prodentrada_params)

    respond_to do |format|
      if @prodentrada.save
        format.html { redirect_to @prodentrada, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @prodentrada }
      else
        format.html { render :new }
        format.json { render json: @prodentrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prodentradas/1
  # PATCH/PUT /prodentradas/1.json
  def update
    @produto = Produto.find(@prodentrada.produto_id)
    qtdantiga = @prodentrada.quantidade
    respond_to do |format|
      if @prodentrada.update(prodentrada_params)
        format.html { redirect_to @prodentrada, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @prodentrada }
      else
        format.html { render :edit }
        format.json { render json: @prodentrada.errors, status: :unprocessable_entity }
      end

      if qtdantiga > @prodentrada.quantidade
        qtd = qtdantiga - @prodentrada.quantidade
        @produto.estoque = @produto.estoque - qtd
      else 
        if qtdantiga < @prodentrada.quantidade
          qtd = @prodentrada.quantidade - qtdantiga
          @produto.estoque = @produto.estoque + qtd
        end
      end
      @produto.save
    end
  end

  # DELETE /prodentradas/1
  # DELETE /prodentradas/1.json
  def destroy
    @prodentrada.destroy
    @produto = Produto.find(@prodentrada.produto_id)
    respond_to do |format|
      if @produto.estoque >= @prodentrada.quantidade
        format.html { redirect_to prodentradas_url, notice: t('.apagado') }
        format.json { head :no_content }
      else
        format.html { redirect_to prodentradas_url, danger: 'Impossivel excluir, não há estoque disponível.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prodentrada
      @prodentrada = Prodentrada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prodentrada_params
      params.require(:prodentrada).permit(:entrada_id, :produto_id, :quantidade)
    end
end
