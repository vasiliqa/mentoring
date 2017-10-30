require 'rails_helper'

RSpec.describe ChildrenController, type: :controller do
  render_views

  let! (:orphanage) { create :orphanage}
  let! (:admin) { create :user, :admin, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }

  let(:valid_attributes) do
    {
      first_name: 'Adolf',
      last_name: 'Hitler',
      middle_name: 'Shickle',
      orphanage_id: orphanage.id,
      mentor_id: mentor.id
    }
  end

  let(:invalid_attributes) do
    {
      first_name: 'Adolf',
      middle_name: 'Shickle',
      mentor_id: mentor.id
    }
  end

  before(:each) { sign_in admin }

  describe "GET index" do
    it "assigns all children as @children" do
      child = Child.create! valid_attributes
      get :index
      expect(assigns(:children)).to eq([child])
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    it "assigns the requested child as @child" do
      child = Child.create! valid_attributes
      get :show, params: { id: child.to_param }
      expect(assigns(:child)).to eq(child)
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do
    it "assigns a new child as @child" do
      get :new
      expect(assigns(:child)).to be_a_new(Child)
      expect(response.status).to eq(200)
    end
  end

  describe "GET edit" do
    it "assigns the requested child as @child" do
      child = Child.create! valid_attributes
      get :edit, params: { id: child.to_param }
      expect(assigns(:child)).to eq(child)
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Child" do
        expect do
          post :create, params: { child: valid_attributes }
        end.to change(Child, :count).by(1)
        expect(assigns(:child)).to be_a(Child)
        expect(assigns(:child)).to be_persisted
        expect(response).to redirect_to(Child.last)
      end
    end

    describe "with invalid params" do
      it "does not create a new Child" do
        expect do
          post :create, params: {child: invalid_attributes}
        end.not_to change(Child, :count)
        expect(assigns(:child)).to be_a_new(Child)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { { first_name: 'Kastro' } }

      it "updates the requested child" do
        child = Child.create! valid_attributes
        put :update, params: { id: child.to_param, child: new_attributes }
        child.reload
        expect(child.first_name).to eq('Kastro')
        expect(assigns(:child)).to eq(child)
        expect(response).to redirect_to(child)
      end
    end

    describe "with invalid params" do
      it "does not update the requested child" do
        child = Child.create! valid_attributes
        put :update, params: { id: child.to_param, child: { first_name: nil } }
        child.reload
        expect(child.first_name).to eq('Adolf')
        expect(assigns(:child)).to eq(child)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested child" do
      child = Child.create! valid_attributes
      expect do
        delete :destroy, params: { id: child.to_param }
      end.to change(Child, :count).by(-1)
      expect(response).to redirect_to(children_url)
    end
  end
end
