require 'spec_helper'

describe Cornerstone::Category do

  # == SCOPES == #

  # == VALIDATIONS == #


  context "Validations:" do
    before do
      @category = Factory(:category)
    end

    [:name, :category_type].each do |attr|
      it "requires a #{attr}" do
        @category.send("#{attr}=", nil)
        @category.should have(1).error_on(attr)
      end
    end

    it "#name should be 50 characters or less" do
      @category.name = random_alphanumeric(51)
      @category.should have(1).error_on(:name)
    end

    it "should only include the hard coded category types" do
      @category.category_type = "wiggles"
      @category.should have(1).error_on(:category_type)
    end

  end


  # == CALLBACKS == #
  context "Counter Cache" do
    before do
      @category = Factory(:category, :item_count => 1)
    end

    it "is increased when a discussion is created" do
      @category.item_count.should == 1
      @discussion = Factory(:discussion_no_user, :category => @category)
      @category.reload
      @category.item_count.should == 2
    end

    it "is decreased when a discussion is deleted" do
      @discussion = Factory(:discussion_no_user, :category => @category)
      @category.reload
      @category.item_count.should == 2
      @discussion.destroy
      @category.reload
      @category.item_count.should == 1
    end
  end

  # == CLASS METHODS == #
  # == INSTANCE METHODS == #

end

