class AddColumnsToVenda < ActiveRecord::Migration
  def change
    add_column :vendas, :valortarifa, :decimal
    add_column :vendas, :valoreceber, :decimal
    add_column :vendas, :valorcomissao, :decimal
  end
end
