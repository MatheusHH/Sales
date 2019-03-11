class CreateEntradas < ActiveRecord::Migration
  def change
    create_table :entradas do |t|
      t.integer :nf
      t.decimal :valortotal, :decimal

      t.timestamps null: false
    end
  end
end
