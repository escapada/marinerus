# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Siteclients" do
    describe "Admin" do
      describe "siteclients" do
        refinery_login_with :refinery_user

        describe "siteclients list" do
          before do
            FactoryGirl.create(:siteclient, :email => "UniqueTitleOne")
            FactoryGirl.create(:siteclient, :email => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.siteclients_admin_siteclients_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.siteclients_admin_siteclients_path

            click_link "Add New Siteclient"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Email", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Siteclients::Siteclient.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Email can't be blank")
              Refinery::Siteclients::Siteclient.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:siteclient, :email => "UniqueTitle") }

            it "should fail" do
              visit refinery.siteclients_admin_siteclients_path

              click_link "Add New Siteclient"

              fill_in "Email", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Siteclients::Siteclient.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:siteclient, :email => "A email") }

          it "should succeed" do
            visit refinery.siteclients_admin_siteclients_path

            within ".actions" do
              click_link "Edit this siteclient"
            end

            fill_in "Email", :with => "A different email"
            click_button "Save"

            page.should have_content("'A different email' was successfully updated.")
            page.should have_no_content("A email")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:siteclient, :email => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.siteclients_admin_siteclients_path

            click_link "Remove this siteclient forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Siteclients::Siteclient.count.should == 0
          end
        end

      end
    end
  end
end
