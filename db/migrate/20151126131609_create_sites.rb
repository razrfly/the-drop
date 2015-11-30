class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :type
      t.string :url
      t.string :currency
      t.hstore :properties

      t.timestamps null: false
    end
  end
end
