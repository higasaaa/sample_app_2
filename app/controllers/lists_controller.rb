class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
   # 今回はViewへの受け渡しが不要のためローカル変数にする 保存機能を追加したから？と解釈
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end
  
  def index
    @lists = List.all
  end

  def show
    # 今回はレコードを１件だけ取得するため、インスタンス変数名は単数形の@listにする
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    # データ（レコード）を１件取得
    list = List.find(params[:id])
    
    # データ（レコード）を削除
    list.destroy
    
    # 投稿一覧画面へリダイレクト
    redirect_to '/lists'
    
  end
  
  private
  #ストロングパラメータ
  def list_params
    # requireメソッドがデータのオブジェクト名を定め、
    # permitメソッドで変更を加えられる（保存の処理ができる）キーを指定
    params.require(:list).permit(:title, :body, :image)
  end
end
