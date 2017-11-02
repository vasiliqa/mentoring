require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  let (:curator) { create :user, :curator }

  before (:each) { sign_in curator}

  describe '#show' do
    context 'when logged in' do
      it do
        get :show, params: { id: curator.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end
  end

  describe '#update' do
    context 'when logged in' do
      it do
        expect(curator.avatar_file_name).to eq nil
        put :update, params: {
          id: curator.to_param,
          user: { avatar: fixture_file_upload('spec/fixtures/cat.jpg', 'image/png') }
        }
        expect(curator.reload.avatar_file_name).to eq 'cat.jpg'
        expect(response).to redirect_to user_path(curator)
        expect(flash[:notice]).to match(/Аватар успешно сохранён./)
      end
    end
  end
end
