class Venda < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :produto
  belongs_to :vendedor
  belongs_to :modalidade

  validates :vendedor_id, presence: {message: "Pelo menos um vendedor é requerido!"}
  #validates :produto_id, presence: {message: "Pelo menos um produto é requerido!"}
  #validates :modalidade_id, presence: {message: "Pelo menos uma modalidade é requerida!"}
  validates :quantidade, numericality: { only_integer: true }

  validate :baixaestoque, on: :create
  before_destroy :retornaestoque
  before_save :defvalortotal, :defvalortarifa, :defvalorcomissao, :defvaloreceber
 
  
  def baixaestoque
    if self.produto_id.blank? == false
  	  @produto = Produto.find(self.produto_id)
    	if @produto.estoque >= self.quantidade
    		@produto.estoque = @produto.estoque - self.quantidade
    		@produto.save
    	else
    		errors.add(:quantidade, "Não há estoque disponível para este pedido.") if self.quantidade > @produto.estoque
    	end
    else
      errors.add(:produto_id, "Pelo menos um produto é requerido!") if self.produto_id.blank? 
    end
  end

  def retornaestoque
  	@produto = Produto.find(self.produto_id)
  	@produto.estoque = @produto.estoque + self.quantidade
  	@produto.save
  end

  def defvalortotal
    @produto = Produto.find(self.produto_id)
    self.valortotal = self.quantidade * @produto.precovenda
  end

  def defvalortarifa
    if self.modalidade_id.blank? == false
      @produto = Produto.find(self.produto_id)
      @modalidade = Modalidade.find(self.modalidade_id)
      if @modalidade.nome == "Cartao Debito"
        self.valortarifa = self.valortotal * @modalidade.valor
      else
        if @modalidade.nome == "Cartao Credito"
          self.valortarifa = self.valortotal * @modalidade.valor
        else
          if @modalidade.nome == "Cartao Credito Parcelado"
            self.valortarifa = self.valortotal * @modalidade.valor
          else
            self.valortarifa = @modalidade.valor
          end
        end
      end
    else
      errors.add(:modalidade_id, "Pelo menos uma modalidade é requerida!") if self.modalidade_id.blank? 
    end      
  end

  def defvalorcomissao
    @vendedor = Vendedor.find(self.vendedor_id)
    self.valorcomissao = (self.valortotal / 2.round(2)) * @vendedor.porcentagem
  end

  def defvaloreceber
    if self.valortarifa >= 0
      self.valoreceber = self.valortotal - (self.valortarifa + self.valorcomissao)
    else
      self.valoreceber = self.valortotal
    end
  end
  
  ### Consultas ########################################################################3
  def self.search(datainicial, datafinal)
    where("created_at BETWEEN ? AND ?", datainicial.to_date.beginning_of_day, datafinal.to_date.end_of_day)
  end

  def self.searchcomissao(nomevendedor, vendadatainicial, vendadatafinal)
    Venda.joins(:vendedor).where("vendedores.nome ILIKE ? and vendas.created_at BETWEEN ? AND ?", "%#{nomevendedor}%", vendadatainicial.to_date.beginning_of_day, vendadatafinal.to_date.end_of_day).references(:vendedores)
  end
end
