class Vendedor < ActiveRecord::Base
	has_many :vendas, dependent: :restrict_with_error

	validates :nome, presence: { message: "Este campo não pode ficar em branco!"}
	validates :porcentagem, numericality: true
	validates :telefone, length: { is: 11 }
	validates :telefone, numericality: true

	def self.search(search)
		Vendedor.where("nome ILIKE ?", "%#{search}%")
	end 
end
