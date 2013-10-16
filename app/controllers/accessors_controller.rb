class AccessorsController < ApplicationController
 # create a new permission. Access control, if a user will try to change the url to grant permissions
 # for a note he or she do not own, the user will be prompt with a 404 page.
 def new
      @accessor = Accessor.new
	    @note_id = params[:note_id]
      if Note.find(params[:note_id]).user_id != current_user.id
        render :file => 'public/404.html'
      end
 end

 # get all permissions that the current user granted, and all permissions that were granted to the current user.
 def index
    @accessors = Accessor.where("access_owner = ?" , current_user.id)
    @accessors_by_others = Accessor.where("accessor_id = ?" , current_user.id)

 end

  # POST /user
  # POST /user.json
  #Creates a permission via a form. When creation is triggered the method will check if such a permission exist. 
  #If it does create will update the current value (preventing duplicated permissions), else it will create a new permission 
  def create
    idForNote = params[:accessor][:note_id]
    idForAccessor = User.where(email: params[:accessor][:accessor_id]).first.id
    @accessor = Accessor.find_or_initialize_by_note_id_and_accessor_id_and_access_owner(idForNote, idForAccessor , current_user.id)
    @accessor.update_attributes(
        :access_rights => params[:accessor][:access_rights]
    )
    respond_to do |format|
      if @accessor.save
        format.html { redirect_to Note, notice: 'Premission granted' } #
        format.json { render action: 'index', status: :created, location: Note }#
      else
        format.html { render action: 'new' } #
        format.json { render json: @accessor.errors, status: :unprocessable_entity }#
      end
    end
  end

  # allows the user to delete a permission (either a one that the user created or one that granted to the user)
  def destroy
    Accessor.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to accessors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessor
      @accessor = Accessor.find(params[:id])
    end

    # an accessor creation requires an accessor_id, access_right, and note_id.
    def accessor_params
      params.require(:accessor).permit(:accessor_id, :access_rights, :note_id)
    end

end
