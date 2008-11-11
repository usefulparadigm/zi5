class Post < ActiveRecord::Base
  belongs_to :board, :counter_cache => true
  belongs_to :user
  validates_presence_of :title, :message => "필수입력입니다", :unless => Proc.new { |post| post.tmp? }
  # validates_presence_of :body

  acts_as_viewed 
  acts_as_wikitext :body
  
  named_scope :recent, :order => 'notice DESC, created_at DESC'
  named_scope :tmp, :conditions => ['tmp = ?', true]

  def self.tmp!; create(:tmp => true) end
end

