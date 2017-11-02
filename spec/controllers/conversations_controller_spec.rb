require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id, curator_id: curator.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id  }
  let! (:conversation) { curator.send_message(mentor, 'body', 'subj').conversation }

  let :create_attributes do
    {
        recipients: [curator.id],
        body: 'body',
        subject: 'subj'
    }
  end

  let (:valid_reply_attributes) { { body: 'body' } }

  let (:invalid_reply_attributes) { { id: conversation.id } }

  describe '#show' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :show, params: { id: conversation.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end

    context 'when logged out' do
      it do
        get :show, params: { id: conversation.to_param }
        expect(response.status).to eq(302)
        expect(response).to_not render_template('show')
      end
    end
  end

  describe '#new' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :new
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it do
        sign_in mentor
        expect do
          post :create, params: { conversation: create_attributes }
        end.to change(mentor.mailbox.sentbox, :count).by(1)
        expect(response).to redirect_to(conversation_path(mentor.mailbox.sentbox.last))
      end
    end
  end

  describe '#reply' do
    before { sign_in mentor }

    context 'with valid params' do
      it do
        expect do
          post :reply, params: { id: conversation.to_param, message: valid_reply_attributes }
        end.to change(conversation.messages, :count).by(1)
        expect(response).to redirect_to(conversation_path(conversation))
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :reply, params: { id: conversation.to_param, message: invalid_reply_attributes }
        end.not_to change(conversation.messages, :count)
        expect(response).to redirect_to(conversation_path(conversation))
      end
    end
  end

  describe '#trash' do
    context 'when logged in' do
      it do
        sign_in mentor
        expect do
          post :trash, params: { id: conversation.to_param }
        end.to change{conversation.is_trashed?(mentor)}.from(false).to(true)
        expect(response).to redirect_to mailbox_inbox_path
      end
    end
  end

  describe '#untrash' do
    context 'when logged in' do
      it do
        sign_in mentor
        conversation.move_to_trash(mentor)
        expect do
          post :untrash, params: { id: conversation.to_param }
        end.to change{conversation.is_trashed?(mentor)}.from(true).to(false)
        expect(response).to redirect_to mailbox_inbox_path
      end
    end
  end
end
