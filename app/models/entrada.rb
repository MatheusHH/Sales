class Entrada < ActiveRecord::Base
	has_many :prodentradas, dependent: :restrict_with_error
	has_many :produtos, through: :prodentradas
	belongs_to :fornecedor
	has_many :contas, dependent: :restrict_with_error

	validates :nf, numericality: { only_integer: true }
	validates :valortotal, numericality: true
	validates :fornecedor_id, presence: {message: "Pelo menos um fornecedor é requerido!"}


	accepts_nested_attributes_for :prodentradas, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :contas, reject_if: :all_blank, allow_destroy: true

	def total
    	prodentradas.to_a.sum(&:valortotal)
  	end

	def self.searchentradas(entradadatainicial, entradadatafinal)
    	where("created_at BETWEEN ? AND ?", entradadatainicial.to_date.beginning_of_day, entradadatafinal.to_date.end_of_day)
  	end

  	#incluir no bd valor dos produtos e validar com valor total
 
end
