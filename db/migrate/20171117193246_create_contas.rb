class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.string :vencimento
      t.string :pagamento
      t.decimal :valor
      t.references :entrada, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
