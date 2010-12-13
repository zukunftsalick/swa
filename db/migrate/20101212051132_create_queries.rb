class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.references :user
      t.string :destination_address
      t.float  :distance
      t.string :query_term
      t.references :retailer

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
