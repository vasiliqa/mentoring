class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  before_action :main_ability
  before_action :reload_rails_admin, if: :rails_admin_path?

  helper_method :mailbox, :unread_mails_count

  def mailbox
    current_user.mailbox
  end

  def unread_mails_count
    mailbox.receipts(is_read: false).count
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  private

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in? && can?(:read, current_user)
      redirect_to current_user, alert: exception.message
    else
      redirect_to root_path
    end
  end

  def main_ability
    @main_ability ||= Ability.new(current_user)
  end

  def reload_rails_admin
    models = [
      'Album', 'Book', 'Candidate', 'CandidateEducation', 'CandidateFamilyMember', 'Child',
      'Comment', 'Meeting', 'Orphanage', 'Photo', 'Report', 'Role', 'User'
    ]
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    Rails.env.development? && controller_path =~ /rails_admin/
  end
end
