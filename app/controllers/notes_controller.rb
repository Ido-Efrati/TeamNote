class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json

  # index - finds all of the notes that belong to the user, or shared with the user that is currently logged in.
  # current_user.notes is the same as this query Note.where("user_id=?", current_user.id)
  def index
    # all the notes owned by the user.
    @notes = current_user.notes
    # all the notes the user can read and write
    @canEditNotes = Accessor.select(:note_id).where("accessor_id = ? AND access_rights = ?", current_user, true)
    @canEditNotes.each do |p|
        p.note = Note.find(p.note_id)
    end
    #all the notes the user can only read
    @canView = Accessor.select(:note_id).where("accessor_id = ? AND access_rights = ?", current_user, false)
    @canView.each do |p|
        p.note = Note.find(p.note_id)
    end


    respond_to do |format|
      format.html {}
      format.js {render 'index.js.erb'}
    end
  end

  #Deprecated  - used to show one single note for the issuer. Please see the design document for reasoning 
  #place holder in case show functionality would be required in the future.
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  # when a users tries to create a note the form will submit the title and the content,
  # the create method will add the current_user id to the note, before the note is saved
  # to the db
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_url, notice: 'Note was successfully created.' }
        format.json { render action: 'index', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to Note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  #delete a note from the db
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

  def not_found
  end

    # requires that each note objecr will have a title, a uid and a content.
    def note_params
      params.require(:note).permit(:title, :user_id ,:content)
    end
end
