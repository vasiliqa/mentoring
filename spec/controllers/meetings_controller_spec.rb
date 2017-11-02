require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }
  # let! (:user) { create :user, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id  }
  let! (:meeting) { create :meeting, mentor_id: mentor.id, child_id: child.id  }
  let! (:rejected_meeting) { create :meeting, state: 'rejected', mentor_id: mentor.id, child_id: child.id  }

  let :valid_attributes do
    {
        date: 4.days.since,
        child_id: child.id,
        mentor_id: child.mentor.id
    }
  end

  let :invalid_attributes do
    {
        date: 4.days.since,
        mentor_id: mentor.id
    }
  end

  before(:each) {sign_in mentor}

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
        get :show, params: { id: meeting.to_param }
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
          post :create, params: { meeting: valid_attributes }
        end.to change(Meeting, :count).by(1)
        expect(response).to redirect_to(Meeting.last)
      end
    end

    context 'with invalid params' do
      it do
        expect do
          post :create, params: { meeting: invalid_attributes }
        end.not_to change(Meeting, :count)
        expect(assigns(:meeting)).to be_a_new(Meeting)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#destroy' do
    context 'destroys the requested meeting' do
      it do
        expect do
          delete :destroy, params: { id: meeting.reload.to_param }
        end.to change(Meeting, :count).by(-1)
        expect(response).to redirect_to(meetings_url)
      end
    end
  end

  describe '#reject' do
    context 'when called for new meeting' do
      it do
        expect do
          get :reject, params: { id: meeting.to_param }
        end.to change{meeting.reload.state}.from('new').to('rejected')
        expect(response).to redirect_to(meetings_url)
      end
    end

    context 'when called for rejected meeting' do
      it do
        expect do
          get :reject, params: { id: rejected_meeting.to_param }
        end.to_not change{rejected_meeting.reload.state}
        expect(response).to redirect_to(meetings_url)
      end
    end
  end

  describe '#reopen' do
    context 'when called for new meeting' do
      it do
        expect do
          get :reopen, params: { id: meeting.to_param }
        end.to_not change{meeting.reload.state}
        expect(response).to redirect_to(meetings_url)
      end
    end

    context 'when called for rejected meeting' do
      it do
        expect do
          get :reopen, params: { id: rejected_meeting.to_param }
        end.to change{rejected_meeting.reload.state}.from('rejected').to('new')
        expect(response).to redirect_to(meetings_url)
      end
    end
  end
end
