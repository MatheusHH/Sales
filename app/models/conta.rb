class Conta < ActiveRecord::Base
  belongs_to :entrada
  has_one :fornecedor, through: :entrada

  validates :vencimento, :valor, presence: true
  validates :valor, numericality: true

  #validate :valida_entrada_id, on: :create



  def valida_entrada_id
    if self.entrada_id.blank?
      errors.add(:entrada_id, "Pelo menos uma entrada é requerida!") 
    end
  end
end
