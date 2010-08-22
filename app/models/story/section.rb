class Story::Section < ActiveRecord::Base

  has_many :stories

  default_scope where("deleted_at IS NULL")

  has_friendly_id :name, :use_slug => true, :max_length => 50

  validates :name, :length => { :maximum => 255 }, :presence => true

end
