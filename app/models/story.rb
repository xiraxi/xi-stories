class Story < ActiveRecord::Base

  belongs_to :author, :foreign_key => :author, :class_name => "User"
  belongs_to :user

  has_friendly_id :title, :use_slug => true, :max_length => 50

  validates :title,   :length => { :maximum => 255 }
  #validates :section, :presence => true
  validates :title,   :presence => true
  validates :intro,   :presence => true
  validates :content, :presence => true
  validates :author,  :presence => true

  validate :existance_of_author
  def existance_of_author
    if author.nil? or not User.confirmed.find_by_id(author.id)
      errors.add :author, I18n.t("activerecord.errors.story.attributes.author.existance")
    end
  end

  scope :active, where("deleted_at IS NULL", :draft => false)

  acts_as_taggable
  # Exclude deleted stories tags 
  def self.tag_counts(*args)
    with_scope(where('stories.deleted_at IS NULL')) do
      super(*args)
    end
  end

end
