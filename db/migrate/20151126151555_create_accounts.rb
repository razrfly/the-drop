class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :site, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
