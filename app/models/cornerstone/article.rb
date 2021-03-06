module Cornerstone
  class Article < ActiveRecord::Base
    # == CONSTANTS == #

    # == ASSOCIATIONS == #
    belongs_to :category, :counter_cache => :item_count

    # == ACCESSIBILITY == #
    # == SCOPES == #

    # == VALIDATIONS == #
    validates_presence_of :title, :body, :category

    # == CALLBACKS == #
    # == CLASS METHODS == #
    # == INSTANCE METHODS == #

  end
end
