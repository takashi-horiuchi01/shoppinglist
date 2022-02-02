class ToppagesController < ApplicationController
  def index
    if logged_in?
      @purchase = current_user.purchases.build  # form_with 用
      @user = User.find(current_user.id)
      @pagy, @purchases = pagy(Purchase.order(id: :desc))
    end
  end
end