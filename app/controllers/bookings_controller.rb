class BookingsController < ApplicationController
    def create
        @stripe_service=StripeService.new
        @workshop=Workshop.find(params[:workshop_id])
        @customer=Customer.find_by({email:params[:email]})
        unless @customer.present?
            @customer=Customer.create(customer_params)
        end    
        @stripe_customer=@stripe_service.find_or_create_customer(@customer)
        @card=@stripe_service.create_stripe_card_customer(card_params,@stripe_customer)
        @amount_to_be_paid=params[:no_of_tickets].to_i *
        @workshop.registeration_fee

        @charge=@stripe_service.create_stripe_charge(@amount_to_be_paid,
            @stripe_customer.id,@card.id,@workshop)
            
        @booking=@workshop.bookings.create(
            customer_id: @customer.id ,
            stripe_transaction_id: @charge.id,
            no_of_tickets: params[:no_of_tickets].to_i,
            amount_paid:@amount_to_be_paid
        )
        puts "book#{@booking}"
        BookingsMailer.booking_confirmation(@booking).deliver_now
        redirect_to workshop_path(@workshop) , notice:'Your tickets has been booked'
    rescue Stripe::StripeError => error
        puts error.message
        redirect_to workshop_path(@workshop) , alert:"#{error.message}"

    end


    def booking_details
        @booking=Booking.find(params[:id])
    end


    private
    def customer_params
        params.permit(:full_name,:contact_number,:email)
    end    

    def card_params
        params.permit(:card_number,:exp_year,:exp_month,:cvv)
    end    
end
