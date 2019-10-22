require 'swagger_helper'

describe 'Tasks' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  path '/projects/{project_id}/tasks' do
    get 'A list of Tasks' do
      tags 'Tasks'

      response '200', 'A list of Tasks' do
        let!(:task_one) { create(:task, project: project) }
        let!(:task_two) { create(:task, project: project) }

        it 'returns a list of Tasks' do |example|
          get api_v1_project_tasks_path(project), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects/{project_id}/tasks' do
    post 'Create a Task' do
      tags 'Tasks'

      response '201', 'create a Task' do
        let(:params) { { task: { name: 'Project' } } }

        it 'returns a Task' do |example|
          post api_v1_project_tasks_path(project), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    get 'Show the Task' do
      tags 'Tasks'

      response '200', 'show a Task' do

        it 'returns a Task' do |example|
          get api_v1_task_path(task), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    put 'Update a Task' do
      tags 'Tasks'

      response '200', 'Update the Task' do
        let(:params) { { task: { name: 'New Task' } } }

        it 'return the updated task' do |example|
          put api_v1_task_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{id}' do
    delete 'Delete the Task' do
      tags 'Tasks'

      response '204', 'return No Content' do

        it 'delete the Task' do |example|
          delete api_v1_project_path(task), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{task_id}/complete' do
    patch 'Mark Task as complete' do
      tags 'Task: Complete'

      response '200', 'update Task complete' do
        let(:params) { { task: { done: true } } }

        it 'returns a Task' do |example|
          patch api_v1_task_complete_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{task_id}/position' do
    patch 'Change Position of Task' do
      tags 'Task: Position'

      response '200', 'update Task position' do
        let(:params) { { task: { position: '4' } } }

        it 'returns a Task' do |example|
          patch api_v1_task_position_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
