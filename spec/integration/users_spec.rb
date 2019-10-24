# frozen_string_literal: true

require 'swagger_helper'

describe 'Authentication' do
  let(:user) { create(:user) }
  let(:user_1) { create(:user) }
  let(:tokens) { user.create_new_auth_token }

  after do |example|
    example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end

  path '/auth/sign_in' do
    post 'Sign In' do
      tags 'Authentication'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'Sign In' do
        let(:params) { { email: user.email, password: user.password } }

        it 'returns a current User' do |example|
          post api_v1_user_session_path(params)

          expect(response).to match_json_schema('user_sign_in')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '401', 'Invalid login credentials' do
        let(:params) { { email: user.email, password: '1111' } }

        it 'return error' do |example|
          post api_v1_user_session_path(params)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/auth/sign_out' do
    delete 'Sign Out' do
      tags 'Authentication'
      parameter name: 'access-token', in: :header, type: 'string'
      parameter name: 'client', in: :header, type: 'string'
      parameter name: 'uid', in: :header, type: 'string'
      parameter name: 'token_type', in: :header, type: 'string'

      response '200', 'Sign Out' do
        it 'user Signed out' do |example|
          delete destroy_api_v1_user_session_path(user), headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '404', 'User was not found or was not logged in' do
        it 'return error' do |example|
          delete destroy_api_v1_user_session_path(user)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/auth' do
    post 'Registration' do
      tags 'Authentication'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        }
      }

      response '200', 'Registration' do
        let(:params) { attributes_for(:user) }

        it 'returns a registered User' do |example|
          post api_v1_user_registration_path(params)

          expect(response).to match_json_schema('user_registration')

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'Invalid request' do
        let(:params) { attributes_for(:user, email: '1111') }

        it 'return error' do |example|
          post api_v1_user_registration_path(params)

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
