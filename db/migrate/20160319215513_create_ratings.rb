class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :movie_id
      t.integer :user_id
      t.integer :score

      t.timestamps null: false
    end
    add_index :ratings, :movie_id
    add_index :ratings, :user_id
  end
end
