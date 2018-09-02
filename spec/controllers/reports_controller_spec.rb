require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  render_views

  let!(:curator) { create :user, :curator }
  let!(:mentor) { create :user, :mentor, curator_id: curator.id }

  let!(:report) { create :report, mentor: mentor }
  let!(:rejected_report) { create :report, mentor: mentor, state: :rejected }

  let(:valid_attributes) { attributes_for :report }
  let(:invalid_attributes) { attributes_for :report, description: nil }

  describe '#index' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end
  end

  describe '#show' do
    context 'when logged in' do
      it do
        sign_in mentor
        get :show, params: { id: report.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
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
    before { sign_in mentor }

    context 'with valid params' do
      it do
        expect { post :create, params: { report: valid_attributes } }.to change(Report, :count).by(1)
        expect(response).to redirect_to(Report)
      end
    end

    context 'with invalid params' do
      it do
        expect { post :create, params: { report: invalid_attributes } }.not_to change(Report, :count)
        expect(assigns(:report)).to be_a_new(Report)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#reject' do
    before { sign_in curator }

    context 'when called for new report' do
      it do
        expect do
          get :reject, params: { id: report.to_param }
        end.to change{report.reload.state}.from('new').to('rejected')
        expect(response).to redirect_to reports_path
      end
    end

    context 'when called for rejected report' do
      it do
        expect do
          get :reject, params: { id: rejected_report.to_param }
        end.to_not change{rejected_report.reload.state}
        expect(response).to redirect_to reports_path
      end
    end
  end

  describe '#approve' do
    before { sign_in curator }

    context 'when called for new report' do
      it do
        expect do
          get :approve, params: { id: report.to_param }
        end.to change{report.reload.state}.from('new').to('approved')
        expect(response).to redirect_to reports_path
      end
    end

    context 'when called for rejected report' do
      it do
        expect do
          get :approve, params: { id: rejected_report.to_param }
        end.to_not change{rejected_report.reload.state}
        expect(response).to redirect_to reports_path
      end
    end
  end

  describe '#update' do
    before { sign_in mentor }
    context 'with valid params' do
      it do
        expect do
          put :update, params:  { id: report.id, report: { description: 'Было здорово!' } }
        end.to change{report.reload.description}.from('description').to('Было здорово!')
        expect(response).to redirect_to(report)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          put :update, params:  { id: report.id, report: { description: nil } }
        end.to_not change{report.reload.description}
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys report' do
      sign_in FactoryBot.create(:user, :admin)
      expect { delete :destroy, params: { id: report.id } }.to change(Report, :count).by(-1)
      expect(response).to redirect_to reports_path
    end
  end
end
