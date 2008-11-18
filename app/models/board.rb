class Board < ActiveRecord::Base
  has_many :posts, :conditions => ['tmp = ?', false]
  validates_presence_of :title
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_s; name end
  def to_param; name end
end
