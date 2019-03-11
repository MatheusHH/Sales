class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = Produto.order(:nome).page(params['page']).per(5)
    if params[:search] != ""
      @produtos = Produto.search(params[:search]).page(params['page']).per(5)
    else
      @produtos = Produto.order(:nome).page(params['page']).per(5)
    end
  end

  def rel_estoque
    @produtos = Produto.order(:nome)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ProdutoPdf.new(@produtos, view_context)
        send_data pdf.render, 
                  filename: "produto_.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to @produto, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to @produto, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      if @produto.vendas.size > 0 || @produto.prodentradas.size > 0
        format.html { redirect_to produtos_url, danger: 'Imposivel excluir este produto.' }
        format.json { head :no_content }
      else
        format.html { redirect_to produtos_url, notice: t('.apagado') }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(:categoria_id, :nome, :descricao, :precocompra, :precovenda, :estoque)
    end
end
