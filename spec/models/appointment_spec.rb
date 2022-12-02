require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Appointment, type: :model do
  describe "Validations" do
    %i[doctor_id patient_id date time_slot_id].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
  context 'check has one assosiations' do
      %i[note ].each do |models|
        it 'has one #{models}' do
          relation = described_class.reflect_on_association(models)
          expect(relation.macro).to eq :has_one
        end
      end
    end
    
    context 'check belongs to assosiations' do
      %i[doctor patient time_slot ].each do |models|
        it 'belongs to #{models}' do
          relation = described_class.reflect_on_association(models)
          expect(relation.macro).to eq :belongs_to
        end
      end
    end
end