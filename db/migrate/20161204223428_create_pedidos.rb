class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.references :cliente, index: true, foreign_key: true
      t.string :observacao

      t.timestamps null: false
    end
  end
end
