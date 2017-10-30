require 'rails_helper'

RSpec.describe MailboxController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }

  describe '#inbox' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :inbox
        expect(response.status).to eq(200)
        expect(response).to render_template('inbox')
      end
    end

    context 'when logged out' do
      it do
        get :inbox
        expect(response.status).to eq(302)
        expect(response).to_not render_template('inbox')
      end
    end
  end

  describe '#sent' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :sent
        expect(response.status).to eq(200)
        expect(response).to render_template('sent')
      end
    end

    context 'when logged out' do
      it do
        get :sent
        expect(response.status).to eq(302)
        expect(response).to_not render_template('sent')
      end
    end
  end

  describe '#trash' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :trash
        expect(response.status).to eq(200)
        expect(response).to render_template('trash')
      end
    end

    context 'when logged out' do
      it do
        get :trash
        expect(response.status).to eq(302)
        expect(response).to_not render_template('trash')
      end
    end
  end
end
