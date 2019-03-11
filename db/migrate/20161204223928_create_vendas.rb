class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|
      t.references :pedido, index: true, foreign_key: true
      t.references :produto, index: true, foreign_key: true
      t.integer :quantidade
      t.decimal :valortotal, :decimal

      t.timestamps null: false
    end
  end
end
