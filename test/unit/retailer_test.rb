require 'test_helper'

class RetailerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should have street and zip code in full address" do
    Factory(:retailer)
    assert_equal '100 christopher columbus, 07302', Retailer.first.full_address
  end
end
