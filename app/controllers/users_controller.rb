class UsersController < ApplicationController

  def index

    #need to join users on Secrets!!!!
    @secret = Secret.all
    render 'index'
  end

  def login
    @user = User.find_by email: params[:Email]
    if @user && @user.authenticate(params[:Password])
        session[:name] = @user[:name]
        redirect_to "/users/#{@user[:id]}"
    else
        flash[:alert] = "Invalid Login"
        redirect_to '/sessions/new/'
    end
  end

  def logout
    session.clear
    redirect_to '/sessions/new'
  end

  def new
    render 'new'
  end

  def create

    if params[:Password] == params[:Password_Confirmation]
      user = User.create(email: params[:Email], name: params[:Name], password: [:Password])

      if user.errors.full_messages.any?
        flash[:alert] = "Invalid Login Credentials"
        flash[:error] = user.errors.full_messages
        redirect_to '/users/new'
      else

        session[:name] = user[:name]
        redirect_to "/users/#{user[:id]}"
      end

    else
      flash[:alert] = "Passwords do not match"
      redirect_to '/users/new'
    end
  end

  def edit

    @user = User.find_by name: session[:name]
    render '/users/edit'
  end

  def update

    id = params[:id]

    @user = User.update(id, name: params[:name], email: params[:email], password: params[:password])

    # if params[:password] && params[:password] == params[:Password_Confirmation]
    #
    #   User.update(id, password: params[:password])
    #
    # end

    session[:name] = @user[:name]
    redirect_to "/users/#{params[:id]}"
  end

  def destroy
    User.find(params[:id]).destroy

    redirect_to "/sessions/new"
  end
end
