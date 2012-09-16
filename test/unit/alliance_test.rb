require 'test_helper'

class AllianceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Alliance.new.valid?
  end
end
