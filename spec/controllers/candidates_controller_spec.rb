require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  render_views

  let! (:admin) { create :user, :admin }
  let (:candidate) { create :candidate }

  describe '#index' do
    context 'when loggen in' do
      it do
        sign_in admin
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end
  end

  describe '#show' do
    context 'when loggen in' do
      it do
        sign_in admin
        get :show, params: { id: candidate.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end
  end

  describe '#approve' do
    context 'when loggen in' do
      it do
        sign_in admin
        expect do
          get :approve, params: { id: candidate.to_param }
        end.to change{candidate.reload.state}.from('new').to('approved').and change(User, :count).by(1)
        expect(response).to redirect_to(Candidate.last)
      end
    end
  end

  describe '#new' do
    it "assigns a new candidate as @candidate" do
      get :new
      expect(assigns(:candidate)).to be_a_new(Candidate)
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    let(:valid_attributes) { attributes_for :candidate }

    let(:invalid_attributes) {{ email: "blablabla" }}

    context 'with valid params' do
      it do
        expect do
          post :create, params: { candidate: valid_attributes }
        end.to change(Candidate, :count).by(1)
        expect(response).to render_template('success')
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { candidate: invalid_attributes }
        end.not_to change(Candidate, :count)
        expect(assigns(:candidate)).to be_a_new(Candidate)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#update' do
    it 'updates state comment' do
      sign_in admin
      candidate = create :candidate
      expect(candidate.state_comment).to eq nil
      put :update, params: { id: candidate.id, candidate: { state_comment: 'Отлично!' } }
      expect(candidate.reload.state_comment).to eq 'Отлично!'
      expect(response).to redirect_to candidate_path(candidate)
    end
  end
end
