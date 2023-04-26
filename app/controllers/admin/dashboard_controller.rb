class Admin::DashboardController <AdminController

    def index
        @workshop_count=Workshop.count
        @upcoming_workshops_count=Workshop.upcoming_workshops.count
        @past_workshops_count=Workshop.past_workshops.count
        @customer_count=Customer.count
        @booking_count=Booking.count
        @revenue_earn=Booking.pluck(:amount_paid).sum
        @refundable_bookings=Booking.includes(:workshop).
        @active_refunds=[]
    end   
end    