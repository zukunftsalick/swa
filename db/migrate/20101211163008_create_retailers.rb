class CreateRetailers < ActiveRecord::Migration
  def self.up
    create_table :retailers do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :street_address
      t.string :zipcode

      t.timestamps
    end
  end

  def self.down
    drop_table :retailers
  end
end
