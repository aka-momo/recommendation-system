class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :Name
      t.string :Email

      t.timestamps null: false
    end
  end
end
