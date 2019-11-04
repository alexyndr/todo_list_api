# frozen_string_literal: true

require 'swagger_helper'

describe 'Tasks' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }
  let!(:invalid_task) { create(:task, project: create(:project, :user_trait)) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
    end
  end

  path '/projects/{project_id}/tasks' do
    get 'A list of Tasks' do
      tags 'Tasks'
      parameter name: :project_id, in: :path, type: :string

      response '200', 'A list of Tasks' do
        let!(:task_one) { create(:task, project: project) }
        let!(:task_two) { create(:task, project: project) }

        it 'returns a list of Tasks' do |example|
          get api_v1_project_tasks_path(project), headers: tokens

          expect(response).to match_json_schema('tasks')

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects/{project_id}/tasks' do
    post 'Create a Task' do
      tags 'Tasks'
      parameter name: :project_id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        '$ref' => '#/definitions/task'
      }

      response '201', 'create a Task' do
        let(:params) { { task: { name: 'Project' } } }

        it 'returns a Task' do |example|
          post api_v1_project_tasks_path(project), params: params, headers: tokens

          expect(response).to match_json_schema('task')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '400', 'invalid params' do
        let(:params) { { task: {} } }

        it 'returns error' do |example|
          post api_v1_project_tasks_path(project), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    get 'Show the Task' do
      tags 'Tasks'
      parameter name: :id, in: :path, type: :string

      response '200', 'show a Task' do
        it 'returns a Task' do |example|
          get api_v1_task_path(task), headers: tokens

          expect(response).to match_json_schema('task')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '403', 'unauthorized' do
        it 'returns error' do |example|
          get api_v1_task_path(invalid_task.id)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    put 'Update a Task' do
      tags 'Tasks'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          task: {
            type: :object,
            properties: {
              name: { type: :string, example: 'string' },
              deadline: { type: :datetime, example: '2019-09-22' }
            }
          }
        }
      }

      response '200', 'Update the Task' do
        let(:params) { { task: { name: 'New Task' } } }

        it 'return the updated task' do |example|
          put api_v1_task_path(task), params: params, headers: tokens

          expect(response).to match_json_schema('task')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '403', 'unauthorized' do
        it 'return error' do |example|
          put api_v1_task_path(invalid_task.id)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    delete 'Delete the Task' do
      tags 'Tasks'
      parameter name: :id, in: :path, type: :string

      response '204', 'deleted task' do
        it 'delete the Task' do |example|
          delete api_v1_task_path(task), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '403', 'unauthorized' do
        it 'return error' do |example|
          delete api_v1_task_path(invalid_task.id)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
