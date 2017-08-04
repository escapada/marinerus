module Refinery
  module Ships
    class ShipsController < ::ApplicationController
      # include Refinery::MetaHelper

      before_filter :find_all_ships
      before_filter :find_page

      before_filter :ships_prepare, :only=>[:index]
      before_filter :adds_find

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
        @choices = Choice.scoped
        @visitors = visitors(@ship.id, @ship.created_at)
        # @visitors = visitors(params[:id])

        redirect_to refinery.root_path if @ship.page_status_id == 1

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @ship in the line below
        # (it means that method will use something "like title_field" from your model):
        # present(@ship)

      end

    protected

      def find_all_ships
        @all = Ship.where("page_status_id= 2 AND (status_id IN (1,2,3))").includes(:translations).order('updated_at DESC')
        @ships = Ship.search(params).order('refinery_ships.updated_at DESC')

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

      def adds_find
        @adds = Refinery::Adds::Add.limit(4)
        @adds.order(:positions) if @adds.present?
      end

      #######################
      #number views(visitors) of each ship by Metrika API
      #######################

      def visitors(id, date)
        begin
        # json = Net::HTTP.get_response(URI.parse("https://api-metrika.yandex.ru/stat/v1/data?date1=today&metrics=ym:s:users&filters=ym:pv:URL=@'ships'&id=33242200&oauth_token=8d3f347e9bfe4be49785fc3922ccc4e1"))
          json = Net::HTTP.get_response(URI.parse("https://api-metrika.yandex.ru/stat/v1/data?date1=#{date.strftime("%Y-%m-%d")}&metrics=ym:s:users&filters=ym:pv:URL=@%27ships/#{id}%27&id=33242200&oauth_token=AQAAAAADvq36AAQsNhxUuZrk40_bsQtY8fXNqrU"))
        rescue Exception => e
          logger.debug("---------------------- #{e}")
          retry
        end

        if (json.present? and json.code == "200")
          data_hash = JSON.parse(json.body)
          if data_hash["data"].present?
            visitors = data_hash["data"][0]["metrics"][0] 
          else
            visitors = nil
          end
        else
          visitors = nil
        end

        return visitors
      end


    end
  end
end
