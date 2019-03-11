class AddVendedorToVenda < ActiveRecord::Migration
  def change
    add_reference :vendas, :vendedor, index: true, foreign_key: true
  end
end
