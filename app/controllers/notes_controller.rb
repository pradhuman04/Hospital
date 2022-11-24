class NotesController < ApplicationController
  def create
    @note = @appointment.notes.new(notes_params)
    @note.user_id = current_user.id
    if @note.save
			redirect_to appointment_path(@appointment)
		else
			redirect_to appointments_path(@appointment), notice: 'Unable to add note, try again!'
		end
  end
	def edit
		@note = @appointment.notes.find(params[:id])
	end

	def update
		@note = @appointment.notes.find(params[:id])
		if @note.update(notes_params)
			redirect_to appointment_path(@appointment), notice: 'Updated Note'
		else
			render 'edit', notice: 'Sorry, Unable to update Note, Please try again!'
		end
	end

	def destroy
		@note = @appointment.notes.find(params[:id])
		@note.destroy
		redirect_to appointment_path(@appointment), notice: 'Note destroyed!'
	end

	private
	def notes_params
		params.require(:note).permit(:description)
	end
end