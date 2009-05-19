require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "order_confirmation" do
    @expected.subject = 'OrderMailer#order_confirmation'
    @expected.body    = read_fixture('order_confirmation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, OrderMailer.create_order_confirmation(@expected.date).encoded
  end

end
