class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :vendas, dependent: :restrict_with_error
  has_many :produtos, through: :vendas
  has_many :modalidades, through: :vendas
  has_many :recebimentos, dependent: :restrict_with_error

  validates :cliente_id, presence: true 

  accepts_nested_attributes_for :vendas, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :recebimentos, reject_if: :all_blank, allow_destroy: true
  # no pedido atual, estou somando valores da venda através do metodo, por isso o &
  def valor_total
    vendas.to_a.sum(&:defvalortotal)
  end


  def self.search(search)
		Pedido.joins(:cliente).where("clientes.nome ILIKE ?", "%#{search}%").references(:clientes) 
  end

end
