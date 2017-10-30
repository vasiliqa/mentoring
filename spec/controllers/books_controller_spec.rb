require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:book) { create :book, owner_id: curator.id }

  let :valid_attributes do
    {
        name: 'Lord of Flies',
        priority: Book.priorities.keys.first,
        owner_id: curator.id
    }
  end

  let :invalid_attributes do
    {
        owner_id: curator.id,
        priority: Book.priorities.keys.last
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
        get :show, params: { id: book.to_param }
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

  describe '#create' do
    context 'with valid params' do
      it do
        expect do
          post :create, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)
        expect(response).to redirect_to(books_path)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { book: invalid_attributes }
        end.to_not change(Book, :count)
      expect(assigns(:book)).to be_a_new(Book)
      expect(response).to render_template('new')
      end
      before do
        post :create, params: { book: invalid_attributes }
      end
    end
  end

  describe '#destroy' do
    context 'when logged in' do
      it do
        expect do
          delete :destroy, params: { id: book.to_param }
        end.to change(Book, :count).by(-1)
        expect(response).to redirect_to(books_url)
      end
    end
  end
end
