class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :zipcode
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end