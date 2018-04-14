RailsAdmin.config do |config|
  config.parent_controller = ApplicationController.to_s
  config.main_app_name = ["Детский дом", "Админка"]

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # == Cancan ==
  config.authorize_with :cancan, AdminAbility

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
  config.included_models = [
    'Album',
    'Book',
    'Candidate',
    'CandidateEducation',
    'CandidateFamilyMember',
    'Child',
    'Comment',
    'Meeting',
    'Orphanage',
    'Photo',
    'Report',
    'Role',
    'User'
  ]

  invisible_models = [
    'Album', 'Book', 'Candidate', 'CandidateEducation', 'CandidateFamilyMember', 'Comment',
    'Meeting', 'Photo', 'Report', 'Role'
  ]

  invisible_models.each do |model|
    config.model model do
      visible false
    end
  end

  config.model 'Child' do
    object_label_method do
      :children_name
    end
    edit do
      field :first_name
      field :last_name
      field :middle_name
      field :birthdate do
        datepicker_options keyBinds: { t: nil }, format: parser.to_momentjs
      end
      field :description
      field :avatar
      field :mentor do
        inline_add false
        inline_edit false
      end
      field :orphanage do
        inline_add false
        inline_edit false
      end
    end
  end

  config.model 'Orphanage' do
    edit do
      field :name
      field :address
      field :children do
        inline_add false
      end
      field :users do
        inline_add false
      end
    end
  end

  config.model 'User' do
    edit do
      field :email
      field :password
      field :password_confirmation
      field :first_name
      field :last_name
      field :middle_name
      field :description
      field :display_on_site
      field :avatar
      field :curator do
        inline_add false
        inline_edit false
      end
      field :orphanage do
        inline_add false
        inline_edit false
      end
      field :children do
        inline_add false
      end
      field :roles do
        inline_add false
      end
    end
  end

  Child.class_eval do
    def children_name
      "#{first_name} #{middle_name} #{last_name}"
    end
  end
end
