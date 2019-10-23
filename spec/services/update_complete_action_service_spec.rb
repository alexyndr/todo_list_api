# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::UpdateCompleteActionService do

  subject(:service) { described_class }
  let(:project)  { create(:project, :user_trait) }
  let(:task) { create(:task, project: project) }

  describe 'update task' do
    let(:params) { { done: 'Make money' } }

    it { expect(service.call(task, params).done).to eq true }
  end
end
