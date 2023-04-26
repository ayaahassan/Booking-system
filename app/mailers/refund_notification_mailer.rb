class RefundNotificationMailer < ApplicationMailer

  
  def customer_refund_notification(refund)
    @refund=refund
    @booking=refund.booking
    @customer=refund.customer    
    @workshop=@booking.workshop
    @refundable_amount=@refund.no_of_tickets * @workshop.registeration_fee
    mail to: @customer.email ,subject: "Refund accepted for #{@workshop.name}"
  end

 
  def admin_refund_notification(refund)
    @refund=refund
    @booking=refund.booking
    @customer=refund.customer    
    @workshop=@booking.workshop
    @refundable_amount=@refund.no_of_tickets * @workshop.registeration_fee
    mail to: AdminUser.first.email ,subject: "Refund request coming from #{@workshop.name}"

  end
end
