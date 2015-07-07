module Refinery
  module Ships
    class ShipsController < ::ApplicationController

      before_filter :find_all_ships
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ship in the line below:
        present(@page)
      end

      def show
        @ship = Ship.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ship in the line below:
        present(@page)
      end

    protected

      def find_all_ships
        @ships = Ship.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ships").first
      end

    end
  end
end
