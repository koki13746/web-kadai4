class UsersController < ApplicationController

  def index
    if user_signed_in?
    @users = User.all
    @book = Book.new
    # @user = User.find(params[:id])
    # ↑これ違う可能性高い。:idじゃなくて固定で自分のでいいかも
    # @user = current_user.find
    else
      redirect_to new_user_session_path
    end
  end


  def show
    if user_signed_in?

    @user = User.find(params[:id])
    @users =User.all
    @books = @user.books
    @book = Book.new

    else
      redirect_to new_user_session_path
    end
  end

  def edit
    # @user = User.find(params[:id])

    # if current_user.id != @user.id
    #   redirect_to users_path
    # elsif user_signed_in? == false
    #   redirect_to new_user_session_path


    # end

    if @user = User.find(params[:id])

      if user_signed_in? == true
        if current_user.id != @user.id
          redirect_to user_path(current_user)
        end
      else
        redirect_to new_user_session_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @user = User.find(params[:id])
  if  @user.update(user_params)
    redirect_to user_path , notice: 'Your information was successfully updated.'
  else

    render "edit"
  end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
