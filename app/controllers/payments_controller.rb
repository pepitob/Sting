class PaymentsController < ApplicationController
  def new
    # @order = current_user.participations.joins(:order).where(orders: {state: 'pending', id: params[:order_id]}).first.order
    @order = Order.find(params[:order_id])
    authorize @order
  end
end
