module Cornerstone
  class Discussion < ActiveRecord::Base

    # == CONSTANTS == #
    STATUS = Cornerstone::Config.discussion_statuses

    # == ASSOCIATIONS == #
    belongs_to :category, :counter_cache => :item_count
    # belongs_to 'user' also established by acts_as_cornerstone_user

    has_many :posts, :dependent => :destroy
    accepts_nested_attributes_for :posts

    # == ACCESSIBILITY == #
    attr_accessible :subject, :privte, :category_id, :posts_attributes

    # == SCOPES == #
    default_scope :order => "created_at DESC",
                  :conditions => {:privte => false}

    scope :latest_for_category, lambda { |cat, num=5|
                                         where(:category_id => cat.id)
                                         .limit(num) }

    # == VALIDATIONS == #
    validates :subject, :presence => true,
                        :length => { :maximum => 50 }

    validates :status, :inclusion => { :in => Cornerstone::Discussion::STATUS }

    validates :category, :presence => true

    # == CALLBACKS == #
    after_save :set_latest_discussion, :on => :create

    # == CLASS METHODS == #

    # == INSTANCE METHODS == #
    def author_name
      self.posts.first.author_name
    end

    #######
    private
    #######

    # Update the category's latest discussion author/date
    def set_latest_discussion
      post = self.posts.first
      if post
        cat = self.category
        cat.latest_discussion_author = post.author_name
        cat.latest_discussion_date = Time.now.to_s(:db)
        cat.save
      end
    end


  end

end

