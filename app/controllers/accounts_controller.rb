class AccountsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  # TODO GET /register
  # GET /account/new
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save 
        flash[:notice] = "Registered."
        format.html { redirect_to chips_path }
      else
        flash[:notice] = "Registration failed. Try again."
        format.html { render :action => "new" }
      end
    end
  end

  # GET /account
  def show
    @user = @current_user

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /account/edit
  def edit
    @user = @current_user
  end

  # PUT /account
  def update
    @user = @current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to account_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
