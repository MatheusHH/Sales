class Categoria < ActiveRecord::Base
	has_many :produtos, dependent: :restrict_with_error

	validates :nome, presence: { message: "Este campo não pode ficar em branco!"}
end
