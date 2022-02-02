class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  private


  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  # 家族分全てが表示される仕様のため表示数とカウント数があっていないのが気になる仕様ではある。。
  def count_purchases
    @count_purchases= Purchase.where(status: '0', user_id: @user.id).count + Purchase.where(status: '1', user_id: @user.id).count
  end

  # 自分が登録した購入済アイテムの総数カウント
  def count_purchased
    @count_purchased = Purchase.where(status: '2', user_id: @user.id).count
  end

end