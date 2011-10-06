module Cornerstone
  class Category < ActiveRecord::Base

    # == CONSTANTS == #
    TYPES = ["Discussion", "Article"]

    # == ASSOCIATIONS == #
    has_many :discussions
    has_many :articles

    # == ACCESSIBILITY == #
    attr_accessible :name, :category_type, :description

    # == SCOPES == #

    scope :discussions, lambda { where("cornerstone_categories.category_type = 'Discussion'") }
    scope :articles, lambda { where("cornerstone_categories.category_type = 'Article'") }

    # == VALIDATIONS == #
    validates :name, :presence => true,
                     :length => {:maximum => 50}

    validates :category_type, :inclusion => { :in => Cornerstone::Category::TYPES }

    validates :description, :presence => true,
                            :length => {:maximum => 500}

    # == CALLBACKS == #
    # == CLASS METHODS == #

    # == INSTANCE METHODS == #

    # Provides the latest discussion created for this category
    def latest_discussion
      latest_discussions(1).first
    end

    # Provides the last 'num' discussions created for this category
    def latest_discussions(num=nil)
      Discussion.latest_for_category(self, num)
    end

  end
end

