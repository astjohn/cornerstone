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
  describe "Callbacks:" do
    describe "Counter Cache" do
      before do
        @category = Factory(:category, :item_count => 1)
      end

      it "is increased when an article is created" do
        @category.item_count.should == 1
        Factory(:article, :category => @category)
        @category.reload
        @category.item_count.should == 2
      end

      it "is decreased when a discussion is deleted" do
        article = Factory(:discussion_no_user, :category => @category)
        @category.reload
        @category.item_count.should == 2
        article.destroy
        @category.reload
        @category.item_count.should == 1
      end
    end
  end


  # == CLASS METHODS == #
  # == INSTANCE METHODS == #

end
