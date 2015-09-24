Refinery::Inquiries::InquiriesController.class_eval do
	before_filter :adds_find

  def new
    if params[:lot_id].present?
      @inquiry = ::Refinery::Inquiries::Inquiry.new(lot_id: params[:lot_id])
    else
      @inquiry = ::Refinery::Inquiries::Inquiry.new
    end
  end

  protected

  def adds_find
  	@adds = Refinery::Adds::Add.limit(4)
  end

end