require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :board

  should_require_attributes :title, :message => '필수입력입니다'
  should_require_attributes :body
  
end
