class ToppagesController < ApplicationController
  def index
    if logged_in?
      @purchase = current_user.purchases.build  # form_with 用
      # @pagy, @purchases = pagy(current_user.purchases.order(id: :desc))
      @pagy, @purchases = pagy(Purchase.order(id: :desc))
    end
  end
end