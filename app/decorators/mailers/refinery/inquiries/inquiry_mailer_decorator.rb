Refinery::Inquiries::InquiryMailer.class_eval do

      def confirmation(inquiry, request)
        @inquiry = inquiry
        mail :subject   => Refinery::Inquiries::Setting.confirmation_subject(Globalize.locale),
             :to        => inquiry.email,
             :reply_to  => Refinery::Inquiries::Setting.notification_recipients.split(',').first
      end

      def notification(inquiry, request)
        @inquiry = inquiry
        mail :subject   => Refinery::Inquiries::Setting.notification_subject,
             :to        => Refinery::Inquiries::Setting.notification_recipients,
             :reply_to  => inquiry.email
      end

end
