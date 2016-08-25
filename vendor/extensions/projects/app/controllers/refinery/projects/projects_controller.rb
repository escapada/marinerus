module Refinery
  module Projects
    class ProjectsController < ::ApplicationController

      before_filter :find_all_projects
      before_filter :find_page
      before_filter :adds_find

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @project in the line below:
        present(@page)
      end

      def show
        @project = Project.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @project in the line below:
        present(@page)
      end

    protected

      def find_all_projects
        @projects = Project.order('updated_at DESC')  #.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/projects").first
      end

      def adds_find
        @adds = Refinery::Adds::Add.limit(4)
        @adds.order(:positions) if @adds.present?
      end

    end
  end
end
