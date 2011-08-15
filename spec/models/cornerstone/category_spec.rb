require 'spec_helper'

describe Cornerstone::Category do

  # == ACCESSIBILITY == #
  context "Accessibility:" do
    before do
      @category = Factory(:category)
    end
    {:item_count => 5}.each do |attr, value|
      it "should not let me assign the ##{attr}" do
        @category.should_not allow_mass_assignment_of(attr => value)
      end
    end
  end

  # == SCOPES == #
  context "Scopes:" do
    describe "#discussions" do
      it "returns categories with category_type = Discussion" do
        @category = Factory(:category, :category_type => "Discussion")
        Factory(:category, :category_type => "Article")
        test = Cornerstone::Category.discussions
        test.size.should == 1
        test.should == [@category]
      end
    end
    describe "#articles" do
      it "returns categories with category_type = Article" do
        @category = Factory(:category, :category_type => "Article")
        Factory(:category, :category_type => "Discussion")
        test = Cornerstone::Category.articles
        test.size.should == 1
        test.should == [@category]
      end
    end
  end

  # == VALIDATIONS == #


  context "Validations:" do
    before do
      @category = Factory(:category)
    end

    [:name, :category_type, :description].each do |attr|
      it "requires a #{attr}" do
        @category.send("#{attr}=", nil)
        @category.should have(1).error_on(attr)
      end
    end

    {:name => 50,
     :description => 500}.each do |attr, size|
      it "##{attr} should be #{size} characters or less" do
        @category.send("#{attr}=", random_alphanumeric(size + 1))
        @category.should have(1).error_on(attr)
      end
    end

    it "should only include the hard coded category types" do
      @category.category_type = "wiggles"
      @category.should have(1).error_on(:category_type)
    end

  end


  # == CALLBACKS == #

  # == CLASS METHODS == #

  # == INSTANCE METHODS == #
  context "Instance Methods:" do
    before do
      @category = Factory(:category)
    end

    describe "#latest_discussions" do
      it "calls the latest_discussion scope with the given number of results required" do
        Cornerstone::Discussion.should_receive(:latest_for_category).with(@category, 5)
        @category.latest_discussions(5)
      end
    end

    describe "#latest_discussion" do
      it "returns the latest discussion" do
        d = Factory(:discussion, :category => @category)
        @category.latest_discussion.should == d
      end
    end

  end

end

