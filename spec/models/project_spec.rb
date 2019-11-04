# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'with db columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
