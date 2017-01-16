InquiryMailer.class_eval do
  def rental_property_notification(inquiry)
    @inquiry = inquiry 
    mail(:to => inquiry_recipients(inquiry),  
      :subject => t(:'inquiry_mailer.notification.subject'),
      :from => "\"#{@inquiry.site.title}\" <#{@inquiry.email}>",
      :reply_to => @inquiry.email)
  end
  def sale_property_notification(inquiry)
    @inquiry = inquiry 
    mail(:to => inquiry_recipients(inquiry),  
      :subject => t(:'inquiry_mailer.notification.subject'),
      :from => "\"#{@inquiry.site.title}\" <#{@inquiry.email}>",
      :reply_to => @inquiry.email)
  end
  def annual_rental_notification(inquiry)
    @inquiry = inquiry 
    mail(:to => inquiry_recipients(inquiry),  
      :subject => t(:'inquiry_mailer.notification.subject'),
      :from => "\"#{@inquiry.site.title}\" <#{@inquiry.email}>",
      :reply_to => @inquiry.email)
  end
  def inquiry_recipients(inquiry)
    if inquiry.respond_to?(:property) && inquiry.property && inquiry.property.realty_agent && inquiry.property.realty_agent.email
      inquiry.property.realty_agent.email
    else
      inquiry.site.inquiry_recipients
    end
  end
end
