class CreateDeductions < ActiveRecord::Migration
  def change
    create_table :deductions do |t|
      t.belongs_to :user, index: true
      t.decimal :home_sqf, :precision => 5, :scale => 2
      t.decimal :business_sqf, :precision => 5, :scale => 2
      t.integer :monthly_expenses
      t.decimal :business_kilometers, :precision => 5, :scale => 2
      t.decimal :start_kilometers, :precision => 5, :scale => 2
      t.integer :vehicle_expenses
      t.integer :short_flight
      t.integer :short_meal
      t.integer :short_entertainment
      t.integer :short_lodging
      t.integer :long_flight
      t.integer :long_meal
      t.integer :long_entertainment
      t.integer :long_lodging

      t.timestamps
    end
  end
end
