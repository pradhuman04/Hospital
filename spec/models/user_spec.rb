require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe User, type: :model do
  describe "Validations" do
    %i[first_name last_name date_of_birth].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
