# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Adds" do
    describe "Admin" do
      describe "adds" do
        refinery_login_with :refinery_user

        describe "adds list" do
          before do
            FactoryGirl.create(:add, :title => "UniqueTitleOne")
            FactoryGirl.create(:add, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.adds_admin_adds_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.adds_admin_adds_path

            click_link "Add New Add"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Adds::Add.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Adds::Add.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:add, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.adds_admin_adds_path

              click_link "Add New Add"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Adds::Add.count.should == 1
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.adds_admin_adds_path
                click_link "Add New Add"
                fill_in "Title", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Adds::Add.count.should == 1
              end

              it "should show locale flag for page" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                end
              end

              it "should show title in the admin menu" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a add with title for primary and secondary locale" do
              before do
                visit refinery.adds_admin_adds_path
                click_link "Add New Add"
                fill_in "Title", :with => "First column"
                click_button "Save"

                visit refinery.adds_admin_adds_path
                within ".actions" do
                  click_link "Edit this add"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Adds::Add.count.should == 1
                Refinery::Adds::Add::Translation.count.should == 2
              end

              it "should show locale flag for page" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a title with title only for secondary locale" do
              before do
                visit refinery.adds_admin_adds_path
                click_link "Add New Add"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Adds::Add.last
                within "#add_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:add, :title => "A title") }

          it "should succeed" do
            visit refinery.adds_admin_adds_path

            within ".actions" do
              click_link "Edit this add"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:add, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.adds_admin_adds_path

            click_link "Remove this add forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Adds::Add.count.should == 0
          end
        end

      end
    end
  end
end
