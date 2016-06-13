# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Projects" do
    describe "Admin" do
      describe "projects" do
        refinery_login_with :refinery_user

        describe "projects list" do
          before do
            FactoryGirl.create(:project, :title => "UniqueTitleOne")
            FactoryGirl.create(:project, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.projects_admin_projects_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.projects_admin_projects_path

            click_link "Add New Project"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Projects::Project.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Projects::Project.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:project, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.projects_admin_projects_path

              click_link "Add New Project"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Projects::Project.count.should == 1
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.projects_admin_projects_path
                click_link "Add New Project"
                fill_in "Title", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Projects::Project.count.should == 1
              end

              it "should show locale flag for page" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                end
              end

              it "should show title in the admin menu" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a project with title for primary and secondary locale" do
              before do
                visit refinery.projects_admin_projects_path
                click_link "Add New Project"
                fill_in "Title", :with => "First column"
                click_button "Save"

                visit refinery.projects_admin_projects_path
                within ".actions" do
                  click_link "Edit this project"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Projects::Project.count.should == 1
                Refinery::Projects::Project::Translation.count.should == 2
              end

              it "should show locale flag for page" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a title with title only for secondary locale" do
              before do
                visit refinery.projects_admin_projects_path
                click_link "Add New Project"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Projects::Project.last
                within "#project_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:project, :title => "A title") }

          it "should succeed" do
            visit refinery.projects_admin_projects_path

            within ".actions" do
              click_link "Edit this project"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:project, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.projects_admin_projects_path

            click_link "Remove this project forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Projects::Project.count.should == 0
          end
        end

      end
    end
  end
end
