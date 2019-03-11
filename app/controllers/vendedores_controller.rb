class VendedoresController < ApplicationController
  before_action :set_vendedor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /vendedores
  # GET /vendedores.json
  def index
    @vendedores = Vendedor.all
    if params[:search] != ""
      @vendedores = Vendedor.search(params[:search]).page(params['page']).per(5)
    else
      @vendedores = Vendedor.all.page(params['page']).per(5)
    end
  end

  # GET /vendedores/1
  # GET /vendedores/1.json
  def show
  end

  # GET /vendedores/new
  def new
    @vendedor = Vendedor.new
  end

  # GET /vendedores/1/edit
  def edit
  end

  # POST /vendedores
  # POST /vendedores.json
  def create
    @vendedor = Vendedor.new(vendedor_params)

    respond_to do |format|
      if @vendedor.save
        format.html { redirect_to @vendedor, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @vendedor }
      else
        format.html { render :new }
        format.json { render json: @vendedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendedores/1
  # PATCH/PUT /vendedores/1.json
  def update
    respond_to do |format|
      if @vendedor.update(vendedor_params)
        format.html { redirect_to @vendedor, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @vendedor }
      else
        format.html { render :edit }
        format.json { render json: @vendedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendedores/1
  # DELETE /vendedores/1.json
  def destroy
    @vendedor.destroy
    respond_to do |format|
      if @vendedor.vendas.size > 0
        format.html { redirect_to vendedores_url, danger: 'Imposivel excluir este vendedor !' } 
        format.json { head :no_content }
      else
        format.html { redirect_to vendedores_url, notice: t('.apagado') }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendedor
      @vendedor = Vendedor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendedor_params
      params.require(:vendedor).permit(:nome, :telefone, :porcentagem)
    end
end
