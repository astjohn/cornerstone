module Cornerstone
  class Discussion < ActiveRecord::Base

    # == CONSTANTS == #

    # == ASSOCIATIONS == #
    belongs_to :category, :counter_cache => :item_count
    # belongs_to also established by acts_as_cornerstone_user

    # == ACCESSIBILITY == #
    # == SCOPES == #

    # == VALIDATIONS == #
    validates :name, :presence => true,
                     :length => {:maximum => 50},
                     :if => Proc.new { |d| d.user.nil? }

    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
                      :if => Proc.new { |d| d.user.nil? }

    validates :subject, :presence => true,
                        :length => {:maximum => 50}

    validates :body, :presence => true,
                     :length => {:maximum => 3000}

    # == CALLBACKS == #
    # == CLASS METHODS == #
    # == INSTANCE METHODS == #

  end

end

