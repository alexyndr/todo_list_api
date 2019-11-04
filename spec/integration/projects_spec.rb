# frozen_string_literal: true

require 'swagger_helper'

describe 'Projects' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }

  after do |example|
    if response.body.present?
      example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
    end
  end

  path '/projects' do
    get 'A list of Projects' do
      tags 'Projects'

      response '200', 'A list of Projects' do
        let!(:project_one) { create(:project, user: user) }
        let!(:project_two) { create(:project, user: user) }

        it 'returns a list of Projects' do |example|
          get api_v1_projects_path, headers: tokens

          expect(response).to match_json_schema('projects')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'not authorized' do
        it 'returns error' do |example|
          get api_v1_projects_path

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects' do
    post 'Create a Project' do
      tags 'Projects'
      parameter name: :body, in: :body, required: true, schema: {
        '$ref' => '#/definitions/project'
      }

      response '201', 'Create a Project' do
        let(:params) { { project: { name: 'Project' } } }

        it 'returns the created Projects' do |example|
          post api_v1_projects_path(params), headers: tokens

          expect(response).to match_json_schema('project')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '400', 'wrong params' do
        let(:params) { { project: {} } }

        it 'returns error' do |example|
          post api_v1_projects_path(params), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects/{id}' do
    get 'Shows a Project' do
      tags 'Projects'
      parameter name: :id, in: :path, type: :string

      response '200', 'A Project' do
        let!(:project) { create(:project, user: user) }

        it 'return a Project' do |example|
          get api_v1_project_path(project.id), headers: tokens

          expect(response).to match_json_schema('project')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'not authorized' do
        it 'return error' do |example|
          get api_v1_project_path(1)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects/{id}' do
    put 'Update a Project' do
      tags 'Projects'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        '$ref' => '#/definitions/project'
      }

      response '200', 'Update the Project' do
        let(:params) { { project: { name: 'New Project' } } }
        let(:project) { create(:project, user: user) }

        it 'return the updated Project' do |example|
          put api_v1_project_path(project.id), params: params, headers: tokens

          expect(response).to match_json_schema('project')

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/projects/{id}' do
    delete 'Delete the Project' do
      tags 'Projects'
      parameter name: :id, in: :path, type: :string

      response '204', 'deleted project' do
        let!(:project) { create(:project, user: user) }

        it 'delete the Project' do |example|
          delete api_v1_project_path(project.id), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'not authorized' do
        it 'return error' do |example|
          delete api_v1_project_path(1)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
