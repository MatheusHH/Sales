class CreateModalidades < ActiveRecord::Migration
  def change
    create_table :modalidades do |t|
      t.string :nome
      t.decimal :valor

      t.timestamps null: false
    end
  end
end
