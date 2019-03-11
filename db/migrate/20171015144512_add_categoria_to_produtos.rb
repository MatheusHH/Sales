class AddCategoriaToProdutos < ActiveRecord::Migration
  def change
    add_reference :produtos, :categoria, index: true, foreign_key: true
  end
end
