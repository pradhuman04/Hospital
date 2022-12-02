require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Note, type: :model do
  context 'check belongs to assosiations' do
    %i[appointment user].each do |models|
      it 'belongs to #{models}' do
        relation = described_class.reflect_on_association(models)
        expect(relation.macro).to eq :belongs_to
      end
    end
  end
end