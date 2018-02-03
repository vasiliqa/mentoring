require 'rails_helper'

RSpec.describe MainController, type: :controller do
  render_views

  describe 'get #index' do
    it 'responds with 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'get #about' do
    it 'responds with 200' do
      get :about
      expect(response.status).to eq(200)
    end
  end

  describe 'get #contacts' do
    it 'responds with 200' do
      get :contacts
      expect(response.status).to eq(200)
    end
  end

  xdescribe 'get #friendship' do
    context 'when there are no friendly children' do
      it 'responds with 200' do
        get :friendship
        expect(response.status).to eq(200)
      end
    end

    context 'when there is at least one friendly child' do
      it 'responds with 200' do
        create :child, is_friendly: true
        get :friendship
        expect(response.status).to eq(200)
      end
    end
  end
end
