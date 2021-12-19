class StripeController < ApplicationController
  def create_checkout_session
    session = Stripe::Checkout::Session.create({
       line_items: [{price: '{{PRICE_ID}}', quantity: 1, }],
       mode: 'payment',
       success_url: 'http://localhost:3000/success.html',
       cancel_url: 'http://localhost:3000/cancel.html',
    })

    redirect_to session.url, status: 303
  end
end
