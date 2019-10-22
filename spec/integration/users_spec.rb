require 'swagger_helper'

describe 'Authentication' do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }

  path '/auth/sign_in' do
    post 'Sign In' do
      tags 'Authentication'

      response '200', 'Sign In' do
        let(:params) { { email: user.email, password: user.password } }

        it 'returns a current User' do |example|
          post api_v1_user_session_path(params)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/auth/sign_out' do
    delete 'Sign Out' do
      tags 'Authentication'

      response '200', 'Sign Out' do
        it 'user Signed out' do |example|
          delete destroy_api_v1_user_session_path(user), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/auth' do
    post 'Registration' do
      tags 'Authentication'

      response '200', 'Registration' do
        let(:params) { attributes_for(:user) }

        it 'returns a registered User' do |example|
          post api_v1_user_registration_path(params)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end