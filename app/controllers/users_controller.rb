class UsersController < ApplicationController
 # before_action :set_user, only: [:show]
  def index
       @users = User.all
  end

  def new
        @user = User.new
  end

  # POST /user
  # POST /user.json
  #Creates a new user via the sign up form. Upon secessful creation the user will have a session and will be redirected to 
  # his or her notes
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to Note, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: Note }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
  #At the moment not being used in phase 3. Backend to support future updates to the user
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #At the moment not being used in phase 3. Backend to support future edits/show to the user
  def edit
  end

  def show
  end

  # DELETE /user/1
  # DELETE /user/1.json
    #At the moment not being used in phase 3. Backend to support deletion of a user
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # a user creation requires a name, email, password and password confirmation.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
