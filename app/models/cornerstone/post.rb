module Cornerstone
  class Post < ActiveRecord::Base

    belongs_to :discussion
    # belongs_to 'user' also established by acts_as_cornerstone_user

    # == CONSTANTS == #
    # == ASSOCIATIONS == #
    # == ACCESSIBILITY == #
    attr_accessible :body, :name, :email

    # == SCOPES == #
    default_scope :order => "created_at ASC"

    # == VALIDATIONS == #

    validates :body, :presence => true,
                     :length => {:maximum => 3000}

    validates :name, :presence => true,
                     :length => { :maximum => 50 },
                     :if => Proc.new { |p| !p.try(:user) }

    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                      :if => Proc.new { |p| !p.try(:user) }

    # == CALLBACKS == #
    after_save :update_counter_cache
    after_create :set_latest_post
    before_save :sanitize_attributes
    after_destroy :update_counter_cache





    # == CLASS METHODS == #


    # == INSTANCE METHODS == #

    # return the author name of the post
    def author_name
      #@cornerstone_name ||= anonymous_or_user_attr(:name)
      anonymous_or_user_attr(:cornerstone_name)
    end

    # return the author email of the post
    def author_email
      #@cornerstone_email ||= anonymous_or_user_attr(:email)
      anonymous_or_user_attr(:cornerstone_email)
    end

    # returns true if it was created by given user or if given user is an admin
    def created_by?(check_user)
      return false unless check_user.present?
      return true if check_user.cornerstone_admin?
      self.user && self.user == check_user
    end

    #######
    private
    #######

    # sanitize attributes
    def sanitize_attributes
      [:name, :email, :body].each do |attr|
        self.send("#{attr}=", Sanitize.clean(self.send(attr),
                              Cornerstone::Config.sanitize_options))
      end
    end

    # Custom counter cache.  Does not include the first post of a discussion.
    def update_counter_cache
      self.discussion.reply_count = Post.where(:discussion_id => self.discussion.id)
                                        .count - 1
      self.discussion.save
    end

    # Returns the requested attribute of the user if it exists, or post's attribute
    def anonymous_or_user_attr(attr)
      unless self.user_id.nil?
        mthd = "user_#{attr.to_s}"
        # TODO: rails caching is messing this relationship up.
        #       will .user work even if model name is something else. e.g. AdminUser ??
        self.user.send(attr)
      else
        case attr
        when :cornerstone_name
          self.send(:name)
        when :cornerstone_email
          self.send(:email)
        end
      end
    end

    # Update the discussion's latest post author/date
    def set_latest_post
      unless self.discussion.nil?
        self.discussion.latest_post_author = self.author_name
        self.discussion.latest_post_date = Time.now.to_s(:db)
        self.discussion.save
      end
    end


  end
end
