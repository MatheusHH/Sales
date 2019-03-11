class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.string :nome
      t.string :descricao
      t.decimal :precocompra, :decimal
      t.decimal :precovenda, :decimal
      t.integer :estoque

      t.timestamps null: false
    end
  end
end
