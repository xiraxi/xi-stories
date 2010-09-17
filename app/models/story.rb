class Story < ActiveRecord::Base

  belongs_to :author, :foreign_key => :author, :class_name => "User"
  belongs_to :user
  belongs_to :section, :class_name => "Story::Section"

  has_friendly_id :title, :use_slug => true, :max_length => 50
  has_comments

  validates :title,   :length => { :maximum => 255 }, :presence => true
  validates :section, :presence => true
  validates :intro,   :presence => true
  validates :content, :presence => true
  #validates :author,  :presence => true

  #validate :existance_of_author
  def existance_of_author
    if author.nil? or not User.confirmed.find_by_id(author.id)
      errors.add :author, I18n.t("activerecord.errors.story.attributes.author.existance")
    end
  end

  default_scope   where("deleted_at IS NULL").order("date, created_at DESC")
  scope :draft,   where(:draft => true)
  scope :visible, where(:draft => false)
  scope :by_lang, proc { |locale| where(:lang => locale) }

  acts_as_taggable

  # filter stories by locale
  def self.tag_counts_on(*args)
    with_scope(where(:lang => I18n.locale.to_s)) do
      super(*args)
    end
  end

  has_text_search :title, :intro, :content

end
