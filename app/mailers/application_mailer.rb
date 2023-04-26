class ApplicationMailer < ActionMailer::Base
  default from: "no-replay@booking.com"
  layout "mailer"
end
