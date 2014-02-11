class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.belongs_to :user, index: true
      t.decimal :interest_annual, :precision => 5, :scale => 2
      t.integer :duration
      t.integer :present_balance
      t.integer :future_value
      t.integer :budget_monthly

      t.timestamps
    end
  end
end
