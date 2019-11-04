# frozen_string_literal: true

require 'swagger_helper'

describe 'Position' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }

  after do |example|
    example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end

  path '/tasks/{id}/position' do
    patch 'Change Position of Task' do
      tags 'Task: Position'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          task: {
            type: :object,
            properties: {
              position: { type: :integer, example: '0' }
            }
          }
        }
      }

      response '200', 'update Task position' do
        let(:params) { { task: { position: '4' } } }

        it 'returns a Task' do |example|
          patch api_v1_position_path(task), params: params, headers: tokens

          expect(response).to match_json_schema('task')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid params' do
        let(:params) { { task: { done: 'true' } } }

        it 'returns error' do |example|
          patch api_v1_position_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
