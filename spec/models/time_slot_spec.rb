require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe TimeSlot, type: :model do
  describe "Validations" do
    %i[slot].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    context 'check has many assosiations' do
      %i[appointments].each do |models|
        it 'has many #{models}' do
          relation = described_class.reflect_on_association(models)
          expect(relation.macro).to eq :has_many
        end
      end
    end
  end
end