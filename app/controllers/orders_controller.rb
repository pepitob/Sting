class OrdersController < ApplicationController
  def create
    participation = Participation.find(params[:participation_id])
    order  = Order.create!(participation: participation, amount: participation.challenge.price, state: 'pending')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: participation.challenge.name,
        amount: participation.challenge.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
