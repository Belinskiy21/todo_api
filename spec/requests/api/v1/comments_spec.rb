require 'rails_helper'

RSpec.describe 'Comments API' do
  # Initialize the test data
  let!(:project) { create(:project) }
  let!(:tasks) { create_list(:task, 10, project_id: project.id) }
  let!(:task) { tasks.first }
  let!(:task_id) { tasks.first.id }
  let!(:comments) { create_list(:comment, 20, task_id: task.id) }
  let(:project_id) { project.id }
  let(:id) { comments.first.id }

  # Test suite for GET /api/v1/projects/:project_id/tasks/:task_id/comments
  describe 'GET /api/v1/projects/:project_id/tasks/:task_id/comments' do
    before { get "/api/v1/projects/#{project_id}/tasks/#{task_id}/comments" }

    context 'when project exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all task comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when project does not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for GET /api/v1/projects/:project_id/tasks/:task_id/comments/:id
  describe 'GET /api/v1/projects/:project_id/tasks/:task_id/comments/:id' do
    before { get "/api/v1/projects/:project_id/tasks/:task_id/comments/:id" }

    context 'when tasks comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when tasks comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for PUT /api/v1/projects/:project_id/tasks/:task_id/comments
  describe 'POST /api/v1/projects/:project_id/tasks/:task_id/comments' do
    let(:valid_attributes) { { text: 'Visit Narnia and kill them all!' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/projects/#{project_id}/tasks/#{task_id}/comments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/projects/#{project_id}/tasks/#{task_id}/comments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /api/v1/projects/:project_id/tasks/:task_id/comments/:id
  describe 'DELETE /api/v1/projects/:project_id/tasks/:task_id/comments/:id' do
    before { delete "/api/v1/projects/#{project_id}/tasks/#{task_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
