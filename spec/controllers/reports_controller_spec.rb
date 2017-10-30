require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, curator_id: curator.id, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id }
  let! (:meeting) { create :meeting, child_id: child.id, mentor_id: child.mentor.id }

  let! :report do
    create :report,
           meeting_id: meeting.id,
           duration: 2,
           aim: 'qq',
           short_description: 'short_description',
           feelings: 'feelings',
           questions: 'questions',
           next_aim: 'next_aim',
           result: 'ww',
           other_comments: 'other_comments'
  end

  let! :rejected_report do
    create :report,
           meeting_id: meeting.id,
           state: 'rejected',
           duration: 2,
           aim: 'qq',
           short_description: 'short_description',
           feelings: 'feelings',
           questions: 'questions',
           next_aim: 'next_aim',
           result: 'ww',
           other_comments: 'other_comments'
  end

  let :valid_attributes do
    {
        duration: 3,
        meeting_id: meeting.id,
        aim: 'qwe asd',
        short_description: 'short_description',
        feelings: 'feelings',
        questions: 'questions',
        next_aim: 'next_aim',
        result: 'ww',
        other_comments: 'other_comments'
    }
  end

  let :invalid_attributes do
    {
        duration: 3,
        meeting_id: meeting.id,
        result: 'asd zxc'
    }
  end

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
        get :new, params: { meeting_id: meeting.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#create' do
    before { sign_in mentor }

    context 'with valid params' do
      it do
        expect  do
          post :create, params: { report: valid_attributes }
        end.to change(Report, :count).by(1)
        expect(response).to redirect_to(Meeting)
      end
    end

    context 'with invalid params' do
      it do
        expect  do
          post :create, params: { report: invalid_attributes }
        end.not_to change(Report, :count)
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
        report = create :report, meeting: meeting
        expect do
          put :update, params:  { id: report.id, report: { short_description: 'Было здорово!' } }
        end.to change{report.reload.short_description}.from('short_description').to('Было здорово!')
        expect(response).to redirect_to(report)
      end
    end

    context 'with invalid params' do
      it do
        report = create :report, meeting: meeting
        expect do
          put :update, params:  { id: report.id, report: { short_description: nil } }
        end.to_not change{report.reload.short_description}
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys report' do
      sign_in FactoryBot.create(:user, :admin)
      report = create :report, meeting: meeting
      expect do
        delete :destroy, params: { id: report.id }
      end.to change(Report, :count).by(-1)
      expect(response).to redirect_to reports_path
    end
  end
end
