class AddModalidadeToVenda < ActiveRecord::Migration
  def change
    add_column :vendas, :modalidade, :string
  end
end
