class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.string :origin_ip
      t.string :destination_address
      t.float :distance

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
