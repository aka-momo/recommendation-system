class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :image_url
      t.string :imdb_url
      t.string :release_date

      t.timestamps null: false
    end
  end
end
