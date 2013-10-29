class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :emails
      t.string :name

      t.timestamps
    end
  end
end
