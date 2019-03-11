class AddFieldToRecebimento < ActiveRecord::Migration
  def change
    add_column :recebimentos, :vencimento, :string
    add_column :recebimentos, :pagamento, :string
  end
end
