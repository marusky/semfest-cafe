class PagesController < ApplicationController
  include Turbo::Broadcastable
  def home
  end

  def spotlight
    @order = Order.new
  end

  def spotlight_now
    @order = Order.find_by(number: order_params[:number], color: order_params[:color])

    broadcast_append_to :orders, partial: "orders/number", target: 'orders-in-preparation', locals: { order: @order }
  end

  private

  def order_params
    params.require(:order).permit(:number, :color)
  end

  def model_name
    Order
  end
end
