class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.belongs_to :user
      t.integer :income
      t.integer :taxes
      t.integer :rrsp

      t.timestamps
    end
  end
end
