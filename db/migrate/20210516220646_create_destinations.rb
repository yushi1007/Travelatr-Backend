class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :image
      t.string :description
      t.boolean :us
      t.string :airport_code
      t.text :photos, array: true
      t.float :rating
      t.text :reviews, array:true
      t.integer :user_ratings_total

      t.timestamps
    end
  end
end
