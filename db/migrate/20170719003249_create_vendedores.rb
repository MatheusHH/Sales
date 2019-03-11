class CreateVendedores < ActiveRecord::Migration
  def change
    create_table :vendedores do |t|
      t.string :nome
      t.string :telefone
      t.decimal :porcentagem

      t.timestamps null: false
    end
  end
end
