class PurchasesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.save
      flash[:success] = '新規の購入リストを登録しました。'
      redirect_to root_url
    else
      @pagy, @purchases = pagy(current_user.purchases.order(id: :desc))
      flash.now[:danger] = '購入リストの登録に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @purchase.destroy
    flash[:success] = '購入リストから削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def purchase_params
    params.require(:purchase).permit(:item, :url)
  end

  def correct_user
    @purchase = current_user.purchases.find_by(id: params[:id])
    unless @purchase
      redirect_to root_url
    end
  end

end
