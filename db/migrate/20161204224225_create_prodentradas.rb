class CreateProdentradas < ActiveRecord::Migration
  def change
    create_table :prodentradas do |t|
      t.references :entrada, index: true, foreign_key: true
      t.references :produto, index: true, foreign_key: true
      t.integer :quantidade

      t.timestamps null: false
    end
  end
end
