# frozen_string_literal: true

require 'swagger_helper'

describe 'Complete' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }

  after do |example|
    example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end

  path '/tasks/{id}/complete' do
    patch 'Mark Task as complete' do
      tags 'Task: Complete'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          task: {
            type: :object,
            properties: {
              done: { type: :boolean, example: 'true' }
            }
          }
        }
      }

      response '200', 'update Task complete' do
        let(:params) { { task: { done: 'true' } } }

        it 'returns a Task' do |example|
          patch api_v1_complete_path(task), params: params, headers: tokens

          expect(response).to match_json_schema('task')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid params' do
        let(:params) { { task: { position: '2' } } }

        it 'returns error' do |example|
          patch api_v1_complete_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
