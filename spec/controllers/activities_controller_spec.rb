require 'rails_helper'

RSpec.describe PublicActivity::ActivitiesController, type: :controller do
  render_views
  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }

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
end
