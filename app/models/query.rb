class Query < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :retailer, :class_name => "Retailer", :foreign_key => "retailer_id"
end
