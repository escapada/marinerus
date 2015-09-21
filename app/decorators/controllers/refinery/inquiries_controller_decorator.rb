Refinery::Inquiries::InquiriesController.class_eval do

  def new
    if params[:lot_id].present?
      @inquiry = ::Refinery::Inquiries::Inquiry.new(lot_id: params[:lot_id])
    else
      @inquiry = ::Refinery::Inquiries::Inquiry.new
    end
  end

end