class Api::V1::CheckoutController < ApplicationController

  def create
    order = Order.find_by(id: stripe_params[:order_id])
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
        {
          name: 'New Order',
          amount: (order.total_amount * 100).round(0),
          currency: 'usd',
          quantity: 1
      }
      ],
      metadata: {
        order_id: stripe_params[:order_id]
      },
      mode: 'payment',
      success_url: 'http://localhost:3001/orders',
      cancel_url: 'http://localhost:3001/new_order',
    })
    if session
      render json: { id: session.id }, status: :ok
    else
      render json: { error: 'Failed to complete order. Please try again.' }, status: :not_acceptable
    end
  end

  private
  
  def stripe_params
    params.require(:checkout).permit(:order_id, :amount)
  end

end