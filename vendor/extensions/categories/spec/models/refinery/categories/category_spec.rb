require 'spec_helper'

module Refinery
  module Categories
    describe Category do
      describe "validations" do
        subject do
          FactoryGirl.create(:category,
          :rutitle => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:rutitle) { should == "Refinery CMS" }
      end
    end
  end
end
