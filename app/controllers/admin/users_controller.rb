class Admin::UsersController < Admin::AdminController
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def update
    user = User.find(params[:id])

    respond_to do |format|
      if user.update_attributes(params[:user])
        flash[:notice] = 'User updated.'
        format.html { redirect_to admin_root_path }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    user = User.find(params[:id])

    respond_to do |format|
      flash[:notice] = 'Failed to destroy user'
      if user.destroy
        flash[:notice] = 'User destroyed'
      end

      format.html { redirect_to admin_root_path }
    end
  end
end
