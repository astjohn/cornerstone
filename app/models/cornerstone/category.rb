module Cornerstone
  class Category < ActiveRecord::Base

    # == CONSTANTS == #
    TYPES = [:discussion]

    # == ASSOCIATIONS == #
    has_many :discussions

    # == ACCESSIBILITY == #
    # == SCOPES == #

    # == VALIDATIONS == #
    validates :name, :presence => true,
                     :length => {:maximum => 50}

    validates :category_type, :inclusion => { :in => Cornerstone::Category::TYPES }

    # == CALLBACKS == #
    # == CLASS METHODS == #
    # == INSTANCE METHODS == #

  end
end

