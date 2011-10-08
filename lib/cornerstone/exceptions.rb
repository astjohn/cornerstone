module Cornerstone

  class AccessDenied < StandardError
    attr_writer :default_message

    def initialize(message = nil)
      @message = message
      @default_message = I18n.t(:"unauthorized.default", :default => "You are not authorized to access this page.")
    end

    def to_s
      @message || @default_message
    end
  end
end

