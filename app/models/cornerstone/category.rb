module Cornerstone
  class Category < ActiveRecord::Base

    # == CONSTANTS == #
    TYPES = ["Discussion", "Article"]

    # == ASSOCIATIONS == #
    has_many :discussions

    # == ACCESSIBILITY == #
    # == SCOPES == #

    scope :discussions, lambda { where("cornerstone_categories.category_type = 'Discussion'") }
    scope :articles, lambda { where("cornerstone_categories.category_type = 'Article'") }

    # == VALIDATIONS == #
    validates :name, :presence => true,
                     :length => {:maximum => 50}

    validates :category_type, :inclusion => { :in => Cornerstone::Category::TYPES }

    # == CALLBACKS == #
    # == CLASS METHODS == #
    # == INSTANCE METHODS == #

  end
end

