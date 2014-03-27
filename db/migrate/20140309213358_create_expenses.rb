class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.integer :amount
      t.string :expense_type

      t.timestamps
    end
  end
end
