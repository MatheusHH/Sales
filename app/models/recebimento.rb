class Recebimento < ActiveRecord::Base
  belongs_to :pedido
  has_one :cliente, through: :pedido

  validates :vencimento, :valor, presence: true
  validates :valor, numericality: true

  validate :valida_pedido_id, on: :create



  def valida_pedido_id
    if self.pedido_id.blank?
      errors.add(:pedido_id, "Pelo menos um pedido é requerido!") 
    end
  end
 
  def self.search(search)
  	if search == "abertos"
		Recebimento.where(pagamento: [nil, ''])
	else
		if search == "recebidos"
			Recebimento.where("pagamento != ''")
		else
			Recebimento.order(:vencimento)
		end
	end
  end

  def self.buscacliente(buscacliente)
  	Recebimento.joins(:cliente).where("clientes.nome ILIKE ?", "%#{buscacliente}%")
  end
end
