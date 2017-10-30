require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:album) { create :album, user: curator }

  let :valid_attributes do
    {
        title: '1st album',
        description: 'desc',
        user_id: curator.id
    }
  end

  let :invalid_attributes do
    {
        title: nil,
        description: 'desc',
        user_id: curator.id
    }
  end

  before(:each) {sign_in curator}

  describe '#index' do
    context 'when logged in' do
      it do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end
  end

  describe '#show' do
    context 'when logged in' do
      it do
        get :show, params: { id: album.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end
  end

  describe '#new' do
    context 'when logged in' do
      it do
        get :new
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#edit' do
    context 'when logged in' do
      it do
        get :edit, params: { id: album.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it do
        expect do
          post :create, params: { album: valid_attributes }
        end.to change(Album, :count).by(1)
        expect(response).to redirect_to(Album.last)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { album: invalid_attributes }
        end.not_to change(Album, :count)
        expect(assigns(:album)).to be_a_new(Album)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it do
        expect do
          put :update, params:  { id: album.to_param, album: valid_attributes }
        end.to change{album.reload.title}.to(valid_attributes[:title])
        expect(response).to redirect_to(album)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          put :update, params:  { id: album.to_param, album: invalid_attributes }
        end.to_not change{album.reload.title}
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    context 'when logged in' do
      it do
        expect do
          delete :destroy, params: { id: album.to_param }
        end.to change(Album, :count).by(-1)
        expect(response).to redirect_to(albums_url)
      end
    end
  end
end
