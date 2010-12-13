Factory.define :query do |q|
  q.association :user
  q.association :retailer
  q.destination_address "286 1st St, 07302-2708"
  q.distance 0.316628784050854
  q.query_term "body and soul"
end