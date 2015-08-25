module Refinery
  module Ships
    class ShipsController < ::ApplicationController

      before_filter :find_all_ships
      before_filter :find_page

      before_filter :ships_prepare, :only=>[:index]

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ship in the line below:

        # logger.debug("#{params[:first_date]}")
        # logger.debug("#{(params[:first_date]["(3i)"]+"."+params[:first_date]["(2i)"]+"."+params[:first_date]["(1i)"])}")
        # logger.debug("#{(params[:first_date]["(3i)"]+"."+params[:first_date]["(2i)"]+"."+params[:first_date]["(1i)"]).to_date}")
        # logger.debug("#{params[:first_date]["(1i)"].present?}")
        params[:search] ? @search = Search.new(params[:search]) : @search = Search.new
        present(@page)
      end

      def show
        @ship = Ship.includes(:status).find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ship in the line below:
        present(@page)
      end

    protected

      def find_all_ships
        @all = Ship.where("page_status_id= 2").includes(:translations).order(:updated_at)
        @ships = Ship.search(params)

        logger.debug("////////////////////////////////////////////////#{@ships.size}!!!!!!!!!!!!!!!!!!!")

      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/ships").first
      end

      def ships_prepare
        @categories = Refinery::Categories::Category.includes(:ships).order(Globalize.locale.to_s=="ru" ? :rutitle : :entitle).all 
        #logger.debug("#{@categories.size}, ////////// #{@categories.each {|e| e.title }}")
        # @ships = Refinery::Ships::Ship.includes(:translations).order(:updated_at).all
        # @all = @ships
        @statuss = Status.all
        @areas = Area.all
        @currencies = Currency.all
        @powers = Power.all

      end

    end
  end
end
