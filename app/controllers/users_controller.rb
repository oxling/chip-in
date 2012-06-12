
class UsersController < ApplicationController

	before_filter :login_required, :except => [ :login ]
	before_filter :only => [ :edit, :destroy, :update, :logout ] do |controller|
		if User.exists?(params[:id]) and User.find(params[:id]) == current_user
			return true
		else
			return false
		end
	end
	
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    
    @own_campaigns = @user.campaigns
	  @contributed_campaigns = @user.contributed_campaigns

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html 
      format.json { render :json => @user }
    end
    
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
  
		@user = User.new(params[:user])

		respond_to do |format|
			if @user.save
				new_user_id = User.authenticate(@user.email, @user.password)
				session[:user_id] = new_user_id
				format.json { render :json=> @user }
				format.html { redirect_to campaigns_url}
			else 
				format.html { render :action => "new" }
				format.json { render :json => @user.errors }
			end
		end
		
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
    
  end
  

	# GET /users/login
	# POST /users/login
	def login
		
		if request.post?
			
			email = params[:user][:email]
			password = params[:user][:password]
			
			new_user_id = User.authenticate(email, password)
			if new_user_id
				session[:user_id] = new_user_id
				redirect_to current_user
			else
				redirect_to login_users_path(:failed_to_sign_in => true, :email => email)
			end
			
		end
		
	end
	
	# POST /user/:id/logout
	def logout
	
		respond_to do |format|
			session[:user_id] = nil
			format.html { redirect_to "/" }
			format.json
		end
		
	end

end
