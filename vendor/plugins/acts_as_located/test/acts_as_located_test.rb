require 'test_helper'

class ActsAsLocatedTest < ActiveSupport::TestCase
  load_schema

  test "the truth" do
    assert true
  end

  class Hickwall < ActiveRecord::Base
  end

  class Wickwall < ActiveRecord::Base
  end

  def test_schema_has_loaded_correctly
    assert_equal [], Hickwall.all
    assert_equal [], Wickwall.all
  end
end
