require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:album) { create :album, user: curator }
  let! (:photo) { create :photo, album: album, user: album.user }

  let :valid_attributes do
    {
        description: 'desc',
        image: Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/main_page/social20.png", 'image/png'),
        album_id: album.id,
        user_id: album.user.id
    }
  end

  let :invalid_attributes do
    {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/public/robots.txt", 'text/txt'),
        album_id: album.id,
        user_id: album.user.id
    }
  end

  before(:each) {sign_in curator}

  describe '#show' do
    context 'when logged in' do
      it do
        get :show, params: { id: photo.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it do
        expect do
          post :create, params: { photo: valid_attributes }
        end.to change(Photo, :count).by(1)
        expect(response).to redirect_to(album_path(album))
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { photo: invalid_attributes }
        end.not_to change(Photo, :count)
        expect(response).to redirect_to(album_path(album))
        expect(assigns(:photo)).to be_a_new(Photo)
        expect(response).to redirect_to(album_path(album))
      end
    end
  end

  describe '#destroy' do
    context 'when logged in' do


      it do
        expect do
          delete :destroy, params: { id: photo.to_param }
        end.to change(Photo, :count).by(-1)
        expect(response).to redirect_to(album_url(album))
      end
    end
  end

end
