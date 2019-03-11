class Fornecedor < ActiveRecord::Base
	has_many :entradas, dependent: :restrict_with_error
	has_many :contas, through: :entradas


	validates :nome, presence: { message: "Este campo não pode ficar em branco!"}
	validates :telefone, length: { is: 10 }
	validates :telefone, numericality: true
	validates :cnpj, length: { is: 14 }
	validates :cnpj, numericality: true
end
