require 'spec_helper'

describe Post do
  context "Model" do
    
    it "should not save if a duplicate record exists" do
    post = FactoryGirl.create(:post)
    FactoryGirl.build(:post, guid: post.guid).should_not be_valid
    print post.slug
  end
    
  end
end