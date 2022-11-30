ActiveAdmin.register Appointment do
  filter :doctor, collection: proc { User.get_all_doctors.map { |c| [c.first_name, c.id] } }
  filter :patient, collection: proc { User.get_all_patients.map { |c| [c.first_name, c.id] } }
  filter :note, collection: proc { Note.all.map { |c| [c.description, c.id] } }
  filter :time_slot, collection: proc { TimeSlot.all.map { |c| [c.slot, c.id] } }

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :date, :doctor_id, :patient_id, :time_slot_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :doctor_id, :patient_id, :time_slot_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
