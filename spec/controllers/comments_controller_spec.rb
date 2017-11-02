require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:book) { create :book, owner_id: curator.id }

  let :valid_attributes do
    {
        text: 'Nice!',
        user_id: curator.id,
        commentable_id: book.id,
        commentable_type: 'Book'
    }
  end

  let :invalid_attributes do
    {
        user_id: curator.id,
        commentable_id: book.id,
        commentable_type: 'Book'
    }
  end

  before(:each) {sign_in curator}

  describe '#create' do
    context 'with valid params' do
      it do
        expect do
          post :create, params: { book_id: valid_attributes[:commentable_id], comment: valid_attributes }
        end.to change(Comment, :count).by(1)
        expect(response).to redirect_to(book)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { book_id: valid_attributes[:commentable_id], comment: invalid_attributes }
        end.not_to change(Comment, :count)
        expect(assigns(:comment)).to be_a_new(Comment)
        expect(response).to redirect_to(book)
      end
    end
  end
end
