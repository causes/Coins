class ChipsController < ApplicationController

  before_filter :require_user, :only => [:index, :show, :new, :edit, :create, :destroy, :update, :auto_create, :auto_destroy]

  # GET /chips
  # GET /chips.xml
  def index
    @users = User.all
    @categories = Category.all
    @todays_chips = Chip.today
    @months_chips = Chip.last_month.group_by(&:category)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chips }
    end 
  end

  # GET /chips/
  # GET /chips/1.xml
  def show
    @chip = Chip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chip }
    end
  end

  # GET /chipsnew
  # GET /chips/new.xml
  def new
    @chip = Chip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chip }
    end
  end

  # GET /chips/1/edit
  def edit
    @chip = Chip.find(params[:id])
  end

  # POST /chips
  # POST /chips.xml
  def create
    @chip = Chip.new(params[:chip])

    respond_to do |format|
      if @chip.save
        flash[:notice] = 'Chip was successfully created.'
        format.html { redirect_to(@chip) }
        format.xml  { render :xml => @chip, :status => :created, :location => @chip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chips/1
  # PUT /chips/1.xml
  def update
    @chip = Chip.find(params[:id])

    respond_to do |format|
      if @chip.update_attributes(params[:chip])
        flash[:notice] = 'Chip was successfully updated.'
        format.html { redirect_to(@chip) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chips/1
  # DELETE /chips/1.xml
  def destroy
    @chip = Chip.find(params[:id])
    @chip.destroy

    respond_to do |format|
      format.html { redirect_to(chips_url) }
      format.xml  { head :ok }
    end
  end

  def auto_create
    c = Chip.new(:user_id => params[:user], :category_id => params[:category])
    c.save

    count = c.user.category_count(
      c.category, Date.today)

    respond_to do |format|
      format.js { render :js => "#{c.id}" }
    end
  end

  def auto_destroy
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
