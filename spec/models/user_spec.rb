# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with db colums' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
  end
end
