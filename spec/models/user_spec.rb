require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe User, type: :model do
  describe "Validations" do
    %i[first_name last_name email password].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    %i[first last_name  password].each do |field|
      it { is_expected.to validate_length_of(field) }
    end
    # %i[first_name last_name email ].each do |field|
    #   it { is_expected.to validate_format_of(field) }
    # end

    context 'check has many assosiations' do
      %i[patient_appointments doctor_appointments doctor_specifications notes].each do |models|
        it 'has many #{models}' do
          relation = described_class.reflect_on_association(models)
          expect(relation.macro).to eq :has_many
        end
      end
    end
  end
end
