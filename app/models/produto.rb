class Produto < ActiveRecord::Base
	has_many :vendas, dependent: :restrict_with_error
	has_many :produtos, through: :vendas
	has_many :prodentradas, dependent: :restrict_with_error
	has_many :entradas, through: :prodentradas
	belongs_to :categoria

	validates :nome, presence: true
	validates :estoque, numericality: { only_integer: true }
	validates :precovenda, :precocompra, numericality: true

	def self.search(search)
		where("nome ILIKE ?", "%#{search}%") 
	end

	def nome_preco
    	"#{nome} -- R$ #{precovenda}"
  	end
end
