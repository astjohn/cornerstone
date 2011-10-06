require 'spec_helper'

describe Cornerstone::Article do
  before do
    @article = Factory.build(:article)
  end
  # == CONSTANTS == #
  # == ASSOCIATIONS == #
  # == ACCESSIBILITY == #
  # == SCOPES == #

  # == VALIDATIONS == #
  [:title, :body, :category].each do |attr|
    it "requires a #{attr}" do
      @article.send("#{attr}=", nil)
      @article.should have(1).error_on(attr)
    end
  end

  # == CALLBACKS == #
  # == CLASS METHODS == #
  # == INSTANCE METHODS == #

end

