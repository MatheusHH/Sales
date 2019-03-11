class Prodentrada < ActiveRecord::Base
  belongs_to :entrada
  belongs_to :produto

  validates :produto_id, presence: { message: "Este campo não pode ficar em branco!"}
  validates :quantidade, numericality: { only_integer: true }

  after_create :entradaestoque
  before_destroy :excluirestoque

  def entradaestoque
  	@produto = Produto.find(self.produto_id)
  	@produto.estoque = @produto.estoque + self.quantidade
  	@produto.save
  end

  def excluirestoque
  	@produto = Produto.find(self.produto_id)
  	if @produto.estoque >= self.quantidade 
  		@produto.estoque = @produto.estoque - self.quantidade
  		@produto.save
  	else 
  		errors[:base] << "Impossivel excluir, não há estoque disponível." #opcional
  		return false
  	end
  end


  def valortotal
    @produto = Produto.find(self.produto_id)
    self.quantidade * @produto.precocompra
  end	
end

