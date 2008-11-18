require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  should_have_many :posts
  should_require_unique_attributes :name
end
