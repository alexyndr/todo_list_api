require 'swagger_helper'

describe 'Comments' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  path '/tasks/{task_id}/comments' do
    get 'A list of Comment' do
      tags 'Comments'

      response '200', 'A list of Comment' do
        let!(:comment_one) { create(:comment, task: task) }
        let!(:comment_two) { create(:comment, task: task) }

        it 'returns a list of Comments' do |example|
          get api_v1_task_comments_path(task), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/tasks/{task_id}/comments' do
    post 'Create a Comment' do
      tags 'Comments'

      response '201', 'create a Comment' do
        let(:params) { { comment: { body: 'new comment' } } }

        it 'returns a Comment' do |example|
          post api_v1_task_comments_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/comments/{id}' do
    delete 'Delete the Comment' do
      tags 'Comments'

      response '204', 'return No Content' do
        let(:comment) { create(:comment, task: task) }

        it 'delete the Comment' do |example|
          delete api_v1_comment_path(task), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
