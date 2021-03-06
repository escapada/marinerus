Refinery::PagesController.class_eval do

  before_filter :ships_prepare#, :only=>[:home]
  before_filter :get_currencies
  before_filter :adds_find

    def get_currencies_helper(today_date, prev_date)
        usd_xml = Net::HTTP.get(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01235"))
        euro_xml = Net::HTTP.get(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01239"))
        gbp_xml = Net::HTTP.get(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01035"))
        usd_hash = Hash.from_xml(usd_xml)
        euro_hash = Hash.from_xml(euro_xml)
        gbp_hash = Hash.from_xml(gbp_xml)
        usd = usd_hash["ValCurs"]["Record"]
        euro = euro_hash["ValCurs"]["Record"]
        gbp = gbp_hash["ValCurs"]["Record"]

        session[:query_date] = today_date

        session[:usd] = usd
        session[:euro] = euro
        session[:gbp] = gbp
    end

    def get_currencies_helper_(today_date, prev_date)
      session[:httpSuccess] = false

      usd_xml = Net::HTTP.get_response(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01235"))
      euro_xml = Net::HTTP.get_response(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01239"))
      gbp_xml = Net::HTTP.get_response(URI.parse("http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=#{prev_date}&date_req2=#{today_date}&VAL_NM_RQ=R01035"))
      
      if (usd_xml.is_a?(Net::HTTPSuccess) and euro_xml.is_a?(Net::HTTPSuccess) and gbp_xml.is_a?(Net::HTTPSuccess)) 
        
        logger.debug("Value ////////// #{usd_xml.code} OK") 
        
        usd_hash = Hash.from_xml(usd_xml.body)
        euro_hash = Hash.from_xml(euro_xml.body)
        gbp_hash = Hash.from_xml(gbp_xml.body)

        usd = usd_hash["ValCurs"]["Record"]
        euro = euro_hash["ValCurs"]["Record"]
        gbp = gbp_hash["ValCurs"]["Record"]

        session[:httpSuccess] = true
        session[:query_date] = today_date

        session[:usd] = usd
        session[:euro] = euro
        session[:gbp] = gbp

      else
        logger.debug("Value ////////// #{usd_xml.code} NOT OK") 

        session[:httpSuccess] = false
      end
    end


  protected
  def ships_prepare
    
    @categories = Refinery::Categories::Category.includes(:ships).order(Globalize.locale.to_s=="ru" ? :rutitle : :entitle).all 
    @ships = Refinery::Ships::Ship.includes(:translations, :category, :attachment).where("page_status_id = 2").order('updated_at DESC')
    @all = @ships.where("status_id IN (1,2,3)")
    @last_ships = @ships.where("status_id IN (1,2,3)")
    @demands_ships = @ships.where("status_id IN (4,5,6)")
    logger.debug("#{@last_ships.size}")
    # model for short search on home page
    @search = Refinery::Ships::Search.new
    # for recomended block
    @recomended = @ships.where("on_the_main_flag = TRUE").limit(8)
    if @recomended.size<8
      @all.where("on_the_main_flag = FALSE").sample(8-@recomended.size).each do |e|
        @recomended<<e
      end
    end
    # logger.debug("#{@recomended.size}, ////////// ")
  end

  def get_currencies
    today_date = (Time.now).strftime("%d/%m/%Y")
    # prev_date = (Time.now - 3.days).strftime("%d/%m/%Y")
    prev_date = (Time.now - 15.days).strftime("%d/%m/%Y") # New Year vocation
    if (session[:usd].present? and session[:euro].present? and session[:gbp].present?)
      if (session[:usd][-1]["Date"].to_date<today_date.to_date and session[:query_date].to_date != today_date.to_date)#(today_date.to_date-2.days)
        get_currencies_helper_(today_date, prev_date)
      end
    else
      get_currencies_helper_(today_date, prev_date)
    end

######################
      # get_currencies_helper_(today_date, prev_date)
######################
     
     #logger.debug("#{session[:usd]}, //////////, #{session[:usd][-2]}, //////////, #{session[:usd]}")
     logger.debug("   SESSION:   #{session}")

  end

  def adds_find
    @adds = Refinery::Adds::Add.limit(4)
    @adds.order(:positions) if @adds.present?
    # logger.debug("{{{{{{{{{{{{{{{{{{{{{{{{{{{#{@adds}")
  end

end