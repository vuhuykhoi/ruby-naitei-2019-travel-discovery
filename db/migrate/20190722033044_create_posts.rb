class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.float :vote_point
      t.references :user, foreign_key: true
      t.references :travel_places, foreign_key: true

      t.timestamps
    end
     add_index :posts, [:user_id, :created_at]
  end
end
