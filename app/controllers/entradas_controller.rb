class EntradasController < ApplicationController
  before_action :set_entrada, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /entradas
  # GET /entradas.json
  def index
    @entradas = Entrada.all.page(params['page']).per(5)
    if params[:entradadatainicial] and params[:entradadatafinal] != ""
      @entradas = Entrada.searchentradas(params[:entradadatainicial],params[:entradadatafinal]).page(params['page']).per(5)
    else
      @entradas = Entrada.all.page(params['page']).per(5)
    end
  end

  # GET /entradas/1
  # GET /entradas/1.json
  def show
  end

  # GET /entradas/new
  def new
    @entrada = Entrada.new
  end

  # GET /entradas/1/edit
  def edit
  end

  # POST /entradas
  # POST /entradas.json
  def create
    @entrada = Entrada.new(entrada_params)

    respond_to do |format|
      if @entrada.save
        format.html { redirect_to @entrada, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @entrada }
      else
        format.html { render :new }
        format.json { render json: @entrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entradas/1
  # PATCH/PUT /entradas/1.json
  def update
    respond_to do |format|
      if @entrada.update(entrada_params)
        format.html { redirect_to @entrada, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @entrada }
      else
        format.html { render :edit }
        format.json { render json: @entrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entradas/1
  # DELETE /entradas/1.json
  def destroy
    @entrada.destroy
    respond_to do |format|
      if @entrada.prodentradas.size > 0 || @entrada.contas.size > 0 
        format.html { redirect_to entradas_url, danger: 'Imposivel excluir esta entrada !' }
        format.json { head :no_content }
      else
        format.html { redirect_to entradas_url, notice: t('.apagado') }
        format.json { head :no_content }
      end  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrada
      @entrada = Entrada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entrada_params
      params.require(:entrada).permit(:fornecedor_id, :nf, :valortotal, prodentradas_attributes: [:id, :produto_id, :quantidade, :_destroy],
        contas_attributes: [:id, :vencimento, :pagamento, :valor])
    end
end
