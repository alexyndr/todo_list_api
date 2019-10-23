# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::UpdateActionService do

  subject(:service) { described_class }
  let(:project)  { create(:project, :user_trait) }
  let(:task) { create(:task, project: project) }

  describe 'update task' do
    let(:params) { { name: 'Make money' } }

    it { expect(service.call(task, params).name).to eq params[:name] }
  end
end
