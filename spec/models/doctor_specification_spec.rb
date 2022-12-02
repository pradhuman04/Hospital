require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe DoctorSpecification, type: :model do
  describe "Validations" do
    %i[specialization institute_name clinic_address].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    %i[specialization institute_name  clinic_address].each do |field|
      it { is_expected.to validate_length_of(field) }
    end
    
    context 'check belongs to assosiations' do
      %i[doctor].each do |models|
        it 'belongs to #{models}' do
          relation = described_class.reflect_on_association(models)
          expect(relation.macro).to eq :belongs_to
        end
      end
    end
  end
end