class BooksController < ApplicationController

  def create
    # ストロングパラメーターを使用
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # DBへ保存する
    if @book.save
    #   redirect_to book_path(@book.id) , notice: 'Book was successfully created'
    # else 
    # # @books = Book.all
    # # @user = User.find(params[:id])
    # # @book = Book.new
    # # render "index"
    #   # redirect_to books_path
    # end
    # redirect_to book_path(@book.id), notice: 'Book was successfully created.'
    # @book = Book.new(book_params)
    redirect_to book_path(@book.id) , notice: 'Book was successfully created'


    else 
      @books =Book.all
      render "index", notice:' error'
    end
  end

  def index
    if user_signed_in?
    @books = Book.all
    @book = Book.new
    # @user = User.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in?
    @book = Book.find(params[:id]) 
    # @user = User.find(params[:id])
    # @book.user_id = current_user.id
    # @book = Book.new

    else
      redirect_to new_user_session_path
    end
  end

  def edit

    if @book = Book.find(params[:id]) 
    
      # if current_user.id != @book.user_id.to_i
      #   redirect_to books_path
      # elsif user_signed_in? == false
      #   redirect_to new_user_session_path
    
      if user_signed_in? == true
        if current_user.id != @book.user_id.to_i
          redirect_to books_path
        end
      else
        redirect_to new_user_session_path
      end

    else
      redirect_to new_user_session_path
    end
  end


  def update
    @book = Book.find(params[:id])
    # @book.user_id = current_user.id
    if  @book.update(book_params)
      # redirect_to "/books/:id"
      redirect_to book_path , notice: 'Book was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
       # dbから削除する命令
    # リダイレクトする命令
    book = Book.find(params[:id]) #データ(レコード)を1件取得
    book.destroy #データ（レコード）を削除
    redirect_to books_path #List一覧画面へリダイレクト
  end

  private
  def book_params
    params.require(:book).permit(:title, :body,:user_id)
end
  def user_params
    params.require(:user).permit(:name, :introduction,:profile_image)
  end

end

