class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :guid
      t.string :name
      t.string :author
      t.text :summary
      t.datetime :published_at

      t.timestamps
    end
  end
end
