# frozen_string_literal: true

require 'swagger_helper'

describe 'Comments' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
    end
  end

  path '/tasks/{task_id}/comments' do
    get 'A list of Comment' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :task_id, in: :path, type: :string

      response '200', 'A list of Comment' do
        let!(:comment_one) { create(:comment, task: task) }
        let!(:comment_two) { create(:comment, task: task) }

        it 'returns a list of Comments' do |example|
          get api_v1_task_comments_path(task), headers: tokens

          expect(response).to match_json_schema('comments')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'not authorized' do
        it 'returns error' do |example|
          get api_v1_task_comments_path(task)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{task_id}/comments' do
    post 'Create a Comment' do
      tags 'Comments'
      parameter name: :task_id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        '$ref' => '#/definitions/comment'
      }

      response '201', 'create a Comment' do
        let(:params) { { comment: { body: 'new comment' } } }

        it 'returns a Comment' do |example|
          post api_v1_task_comments_path(task), params: params, headers: tokens

          expect(response).to match_json_schema('comment')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '400', 'wrong params' do
        let(:params) { { comment: {} } }

        it 'returns error' do |example|
          post api_v1_task_comments_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/comments/{id}' do
    delete 'Delete the Comment' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'deleted comment' do
        let(:comment) { create(:comment, task: task) }

        it 'delete the Comment' do |example|
          delete api_v1_comment_path(comment), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'not authorized' do
        it 'return error' do |example|
          delete api_v1_comment_path(1)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
