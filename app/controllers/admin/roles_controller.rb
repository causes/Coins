class Admin::RolesController < Admin::AdminController

  before_filter :require_admin

  def index
    @users = User.all
  end

  def add
    user = User.find(params[:user_id])
    role = params[:role]

    if user != nil
      user.add_role role
      user.save
    end

    respond_to do |format|
      format.html { redirect_to admin_users_path }
    end
  end

  def remove
    user = User.find(params[:user_id])
    role = params[:role]

    if user != nil
      user.remove_role role
      user.save
    end

    respond_to do |format|
      format.html { redirect_to admin_users_path }
    end
  end

end
