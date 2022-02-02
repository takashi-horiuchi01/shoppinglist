module PurchasesHelper
  include Pagy::Backend

  # purchaseテーブルの全件取得
  # TO:menterへ
  # ここで家族グループに限定してデータを取得した方が処理として良い？現実装のようにhtml.erbファイル内のifで除外した方が良い？
  def all_item
    @pagy, @all_item = pagy(Purchase.order(id: :desc))
    # returnが配列になってしまう部分については注意
  end

  # 自分が登録した購入したいアイテムの総数カウント
  # 家族分全てが表示される仕様のため表示数とカウント数があっていないのが気になる仕様ではある。。
  def count_purchases(user)
    @counts_purchases= Purchase.where(status: '0', user_id: user.id).count + Purchase.where(status: '1', user_id: user.id).count
  end

  # 自分が登録した購入済アイテムの総数カウント
  def count_purchased(user)
    @count_purchased = Purchase.where(status: '2', user_id: user.id).count
  end

  
end  