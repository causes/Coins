class ChipsController < ApplicationController

  before_filter :require_user

  # GET /chips
  # GET /chips.xml
  def index
    @users = User.all
    @categories = Category.all
    @todays_chips = Chip.today

    ActiveRecord::Base.include_root_in_json = false
    @chips_json = @todays_chips.to_json# (:only => [:id, :user, :category])
    @users_json = @users.to_json(:only => [:id, :login])
    @categories_json = @categories.to_json(:only => [:id, :name])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chips }
    end 
  end

  def auto_create
    unless current_user.is_approved?
      respond_to do |format|
        format.js { render :js => "fail" }
      end
      return
    end

    c = Chip.new(:user_id => params[:user], :category_id => params[:category])
    c.save

    count = c.user.category_count(
      c.category, Date.today)

    respond_to do |format|
      format.js { render :js => "#{c.id}" }
    end
  end

  def auto_destroy
    unless current_user.is_approved?
      respond_to do |format|
        format.js { render :js => "fail" }
      end
      return
    end

    result = "fail"

    c = Chip.find(params[:chip]) 
    
    if c != nil
      c.destroy
      result = "success"
    end

    respond_to do |format|
      format.js { render :js => result }
    end
  end
end
