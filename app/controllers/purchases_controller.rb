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
  
  def update
    # 対象レコード取得
    @purchase = Purchase.find(params[:id])

    # 更新ステータス処理の分岐
    status_update
    
    # 更新処理
    if @purchase.save
      if @not_update_flag != '1'
        flash[:success] = '購入リストのステータスを更新しました。'
      else
        flash[:danger] = '当該ステータスを更新できるユーザーではありません'
      end
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = '購入リストのステータス更新に失敗しました。'
      render 'toppages/index'
    end
  end
  
  private

  def purchase_params
    # default status=0
    params[:purchase][:status] = "0"
    params.require(:purchase).permit(:item, :url, :status)
  end

  def status_update
    if @purchase.status == '0'
      # 承認時の自分以外チェック
      other_user_check
      if @not_update_flag!='1'
        # status更新処理
        @purchase.status = '1'
      end

    elsif @purchase.status == '1'
      # 購入画面に遷移させられるのは自分の投稿のみ
      own_user_check
      if @not_update_flag!='1'
        # status更新処理
        @purchase.status = '2'
      end
      
    elsif @purchase.status == '2'
      # 購入画面から戻せるのは自分の投稿のみ
      own_user_check
      if @not_update_flag!='1'
        # status更新処理
        @purchase.status = '1'
      end

    else
      # 何もしない
    end
  end

  def correct_user
    @purchase = current_user.purchases.find_by(id: params[:id])
    unless @purchase
      redirect_to root_url
    end
  end

  # 登録ユーザーが他人かチェック
  def other_user_check
    unless @purchase.user_id != current_user.id
      # 更新させない処理
      @not_update_flag = '1'
    end
  end

  # 登録ユーザーが自分かチェック
  def own_user_check
    unless @purchase.user_id == current_user.id
      # 更新させない処理
      @not_update_flag = '1'
    end
  end
  
end
