class Api::V1::WebhooksController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object.metadata
      order = Order.find_by(id: session[:order_id])
      order.status = 'completed'
      order.save
    end

    render json: { message: 'success' }
  end
end