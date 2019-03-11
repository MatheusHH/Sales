class AddSubdomainToUseres < ActiveRecord::Migration
  def change
    add_column :useres, :subdomain, :string
  end
end
