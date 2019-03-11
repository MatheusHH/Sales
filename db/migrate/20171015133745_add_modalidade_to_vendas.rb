class AddModalidadeToVendas < ActiveRecord::Migration
  def change
    add_reference :vendas, :modalidade, index: true, foreign_key: true
  end
end
