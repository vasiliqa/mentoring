require 'rails_helper'

RSpec.describe OrphanagesController, type: :controller do
  render_views

  let! (:admin) { create :user, :admin }

  let(:valid_attributes) do
    {
        name: 'palata №6',
        address: 'hbz'
    }
  end

  let(:invalid_attributes) { { address: 'hbz' } }

  before(:each) { sign_in admin }

  describe "GET index" do
    it "assigns all orphanages as @orphanages" do
      orphanage = create :orphanage
      get :index
      expect(assigns(:orphanages)).to eq([orphanage])
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    it "assigns the requested orphanage as @orphanage" do
      orphanage = create :orphanage
      get :show, params: { id: orphanage.to_param }
      expect(assigns(:orphanage)).to eq(orphanage)
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do
    it "assigns a new orphanage as @orphanage" do
      get :new
      expect(assigns(:orphanage)).to be_a_new(Orphanage)
      expect(response.status).to eq(200)
    end
  end

  describe "GET edit" do
    it "assigns the requested orphanage as @orphanage" do
      orphanage = create :orphanage
      get :edit, params: { id: orphanage.to_param }
      expect(assigns(:orphanage)).to eq(orphanage)
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Orphanage" do
        expect do
          post :create, params: { orphanage: valid_attributes }
        end.to change(Orphanage, :count).by(1)
        expect(assigns(:orphanage)).to be_a(Orphanage)
        expect(assigns(:orphanage)).to be_persisted
        expect(response).to redirect_to(Orphanage.last)
      end
    end

    describe "with invalid params" do
      it "does not create a new Orphanage" do
        expect do
          post :create, params: { orphanage: invalid_attributes }
        end.not_to change(Orphanage, :count)
        expect(assigns(:orphanage)).to be_a_new(Orphanage)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { { name: 'office 407' } }

      it "updates the requested orphanage" do
        orphanage = create :orphanage
        put :update, params: { id: orphanage.to_param, orphanage: new_attributes }
        orphanage.reload
        expect(orphanage.name).to eq(new_attributes[:name])
        expect(assigns(:orphanage)).to eq(orphanage)
        expect(response).to redirect_to(orphanage)
      end
    end

    describe "with invalid params" do
      it "does not update the requested orphanage" do
        orphanage = create :orphanage, name: 'Mark'
        put :update, params: { id: orphanage.to_param, orphanage: { name: nil } }
        orphanage.reload
        expect(orphanage.name).to eq 'Mark'
        expect(assigns(:orphanage)).to eq(orphanage)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested orphanage" do
      orphanage = create :orphanage
      expect do
        delete :destroy, params: { id: orphanage.to_param }
      end.to change(Orphanage, :count).by(-1)
      expect(response).to redirect_to(orphanages_url)
    end
  end
end
