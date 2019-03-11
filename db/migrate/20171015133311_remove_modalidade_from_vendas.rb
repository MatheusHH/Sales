class RemoveModalidadeFromVendas < ActiveRecord::Migration
  def change
    remove_column :vendas, :modalidade, :string
  end
end
