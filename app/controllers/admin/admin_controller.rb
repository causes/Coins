class Admin::AdminController < ApplicationController

  before_filter :require_user, :only => [:index, :add_role, :remove_role]

  def index
    @users = User.all
  end

  def add_role
    user = User.find(params[:user_id])
    role = params[:role]

    if user != nil
      user.add_role role
      user.save
    end

    respond_to do |format|
      format.html { redirect_to admin_admin_path }
    end
  end

  def remove_role
    user = User.find(params[:user_id])
    role = params[:role]

    if user != nil
      user.remove_role role
      user.save
    end

    respond_to do |format|
      format.html { redirect_to admin_admin_path }
    end
  end
end
