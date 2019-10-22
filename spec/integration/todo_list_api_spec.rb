require 'swagger_helper'

describe 'ToDo List API' do

  path '/api/v1/projects' do
    
    post 'Create a project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :project, schema: {
        data: {
          name: { type: :string }
        }
      }
  end

  response '201', 'project created' do
    let(:project) { { name: 'Make money' } }
end