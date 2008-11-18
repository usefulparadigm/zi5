class Post < ActiveRecord::Base
  belongs_to :board, :counter_cache => true
  belongs_to :user

  # self-referential replies
  has_many :replies, :class_name => "Post", :foreign_key => "parent_id", :order => 'created_at'
  belongs_to :post, :class_name => "Post", :foreign_key => "parent_id", :counter_cache => 'replies_count', :dependent => :destroy

  validates_presence_of :title, :message => "필수입력입니다", :unless => Proc.new { |post| post.tmp? }
  validates_presence_of :body
  validates_presence_of :visitor, :unless => Proc.new { |post| post.user }

  acts_as_viewed 
  acts_as_wikitext :body

  named_scope :recent, :order => 'notice DESC, created_at DESC'
  named_scope :tmp, :conditions => ['tmp = ?', true]
  named_scope :title_or_body_like, lambda { |swd| 
    { :conditions => ['title LIKE ? OR body LIKE ?', "%#{swd}%", "%#{swd}%"], :include => :board }}

  def self.tmp!; create(:tmp => true) end

  def author; self.user || visitor end

end

