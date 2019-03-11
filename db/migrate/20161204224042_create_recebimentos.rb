class CreateRecebimentos < ActiveRecord::Migration
  def change
    create_table :recebimentos do |t|
      t.references :pedido, index: true, foreign_key: true
      t.date :vencimento
      t.date :pagamento
      t.decimal :valor, :decimal

      t.timestamps null: false
    end
  end
end
