class Cliente < ActiveRecord::Base
	has_many :pedidos, dependent: :restrict_with_error
	has_many :vendas, through: :pedidos
	has_many :recebimentos, through: :pedidos

	validates :nome, presence: { message: "Este campo não pode ficar em branco!"}
	validates :telefone, length: { is: 11 }
	validates :telefone, numericality: true
	validates :cpf, length: { is: 11 }
	validates :cpf, numericality: true


	def self.buscanome(nome)
		Cliente.where("nome ILIKE ?", "%#{nome}%")
	end 

end
