class RecebimentosController < ApplicationController
  before_action :set_recebimento, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /recebimentos
  # GET /recebimentos.json
  def index
    @recebimentos = Recebimento.order(:vencimento).page(params['page']).per(5)
    if params[:search] != ""
      @recebimentos = Recebimento.search(params[:search]).page(params['page']).per(5)
    else
      if params[:buscacliente] != ""
        @recebimentos = Recebimento.buscacliente(params[:buscacliente]).page(params['page']).per(5)
      else
        @recebimentos = Recebimento.order(:vencimento).page(params['page']).per(5)
      end
    end
  end

  # GET /recebimentos/1
  # GET /recebimentos/1.json
  def show
  end

  # GET /recebimentos/new
  def new
    @recebimento = Recebimento.new
  end

  # GET /recebimentos/1/edit
  def edit
  end

  # POST /recebimentos
  # POST /recebimentos.json
  def create
    @recebimento = Recebimento.new(recebimento_params)

    respond_to do |format|
      if @recebimento.save
        format.html { redirect_to @recebimento, notice: t('.sucesso') }
        format.json { render :show, status: :created, location: @recebimento }
      else
        format.html { render :new }
        format.json { render json: @recebimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recebimentos/1
  # PATCH/PUT /recebimentos/1.json
  def update
    respond_to do |format|
      if @recebimento.update(recebimento_params)
        format.html { redirect_to @recebimento, notice: t('.atualizado') }
        format.json { render :show, status: :ok, location: @recebimento }
      else
        format.html { render :edit }
        format.json { render json: @recebimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recebimentos/1
  # DELETE /recebimentos/1.json
  def destroy
    @recebimento.destroy
    respond_to do |format|
      format.html { redirect_to recebimentos_url, notice: t('.apagado') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recebimento
      @recebimento = Recebimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recebimento_params
      params.require(:recebimento).permit(:pedido_id, :vencimento, :pagamento, :valor)
    end
end
