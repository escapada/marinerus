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

      #///////////////////////////////// my Inquiry mailer methods
      def order_notification(ship)
        @ship = ship
        mail :subject => t('mytranslations.order_notification.subject'),
                :to => Refinery::Inquiries::Setting.notification_recipients,
                :reply_to => ship.client.email
      end
      def published_notification(ship)
        @ship = ship
        mail :subject => "Модератор опубликовал ваш лот / we published your order/demand",
                :to => @ship.client.email,
                :reply_to => Refinery::Inquiries::Setting.notification_recipients.split(',').first
      end
      #///////////////////////////////// my Inquiry mailer methods

end
