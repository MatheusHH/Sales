class RemoveFieldsFromRecebimento < ActiveRecord::Migration
  def change
    remove_column :recebimentos, :vencimento, :date
    remove_column :recebimentos, :pagamento, :date
  end
end
