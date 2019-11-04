# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::UpdatePositionActionService do
  subject(:service) { described_class }
  let(:project)     { create(:project, :user_trait) }
  let(:task)        { create(:task, project: project) }

  describe 'update task' do
    let(:params) { { position: '3' } }

    it { expect(service.call(task, params).position).to eq params[:position].to_i }
  end
end
