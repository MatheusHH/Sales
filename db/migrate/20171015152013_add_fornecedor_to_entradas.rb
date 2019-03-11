class AddFornecedorToEntradas < ActiveRecord::Migration
  def change
    add_reference :entradas, :fornecedor, index: true, foreign_key: true
  end
end
