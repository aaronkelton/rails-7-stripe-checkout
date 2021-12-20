class StripeController < ApplicationController
  def create_checkout_session

    session = Stripe::Checkout::Session.create({
       # verified with hardcoded price id works!
       line_items: [{price: 'price_1K8ZLxIXYzi0RfdpAqA3phiD', quantity: 1, }],
       mode: 'payment',
       success_url: 'http://localhost:3000/success.html',
       cancel_url: 'http://localhost:3000/cancel.html',
    })

    redirect_to session.url, allow_other_host: true, status: :see_other
  end
end
