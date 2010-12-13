class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :address
      t.string :zipcode
      t.float :lat
      t.float :lng
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
