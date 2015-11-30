class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price_cents
      t.string :url
      t.datetime :published_at
      t.references :site, index: true, foreign_key: true
      t.string :image_id
      t.hstore :properties

      t.timestamps null: false
    end
  end
end
