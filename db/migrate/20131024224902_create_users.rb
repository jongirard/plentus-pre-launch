class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname, :null => false
      t.string :email, :null => false

      t.timestamps
    end
  end
end
