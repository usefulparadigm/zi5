class Page < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_wikitext :body
  simply_searchable
  
  def to_param; name end
end
