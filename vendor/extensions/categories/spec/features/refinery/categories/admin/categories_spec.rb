# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Categories" do
    describe "Admin" do
      describe "categories" do
        refinery_login_with :refinery_user

        describe "categories list" do
          before do
            FactoryGirl.create(:category, :rutitle => "UniqueTitleOne")
            FactoryGirl.create(:category, :rutitle => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.categories_admin_categories_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.categories_admin_categories_path

            click_link "Add New Category"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Rutitle", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Categories::Category.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Rutitle can't be blank")
              Refinery::Categories::Category.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:category, :rutitle => "UniqueTitle") }

            it "should fail" do
              visit refinery.categories_admin_categories_path

              click_link "Add New Category"

              fill_in "Rutitle", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Categories::Category.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:category, :rutitle => "A rutitle") }

          it "should succeed" do
            visit refinery.categories_admin_categories_path

            within ".actions" do
              click_link "Edit this category"
            end

            fill_in "Rutitle", :with => "A different rutitle"
            click_button "Save"

            page.should have_content("'A different rutitle' was successfully updated.")
            page.should have_no_content("A rutitle")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:category, :rutitle => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.categories_admin_categories_path

            click_link "Remove this category forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Categories::Category.count.should == 0
          end
        end

      end
    end
  end
end
