class AddCountryAndStateIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country_id, :integer
    add_column :users, :state_id, :integer
  end
end
