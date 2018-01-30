class CandidatesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :update, :approve]
  load_and_authorize_resource only: [:index, :show, :update, :approve]

  def index
    @candidates = @candidates.order created_at: :desc
  end

  def show
  end

  def new
    @candidate = Candidate.new
    @candidate.candidate_educations.new
    @candidate.candidate_family_members.new
    render layout: 'main'
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      CandidatesMailer.bid_received(@candidate).deliver_now
      CandidatesMailer.bid_sent(@candidate).deliver_now
      render template: 'candidates/success', layout: 'main'
    else
      render :new, layout: 'main'
    end
  end

  def update
    if @candidate.update(state_comment_params)
      redirect_to @candidate, notice: 'Комментарий успешно обновлён.'
    else
      render :show, notice: 'Комментарий не удалось изменить.'
    end
  end

  def approve
    if @candidate.approve and @candidate.save
      flash[:notice] = 'Вы одобрили кандидата.'
    else
      flash[:notice] = 'Кандидата не удалось одобрить.'
      flash[:error] = @candidate.errors.full_messages.first
    end

    redirect_to @candidate, flash: {error: flash[:error]}
  end

  private
    def state_comment_params
      params.require(:candidate).permit(:state_comment)
    end

    def candidate_params
      params.require(:candidate).permit(
        :last_name, :first_name, :middle_name, :registration_address, :home_address, :phone_number,
        :email, :birth_date, :russian_citizenship, :confession, :health_status, :serious_diseases,
        :organization_name, :work_contacts, :work_position, :hobby, :martial_status, :program_role,
        :child_age, :child_gender, :invalid_child, :alcohol, :tobacco, :psychoactive, :drugs,
        :child_crime, :disabled_parental_rights, :reports, :photo_rights, :info_about_program,
        :family_attitude, :visit_hours, :want_new, :plan_be_adoptive_parent, :want_be_significant,
        :want_get_experience, :want_more_kids, :want_be_in_team, :want_change_job, :pity_kids,
        :want_pass_experience, :maternal_instinct, :want_increase_status, :foreign_child,
        :unsolvable_problems, :tragic_events, :child_emotions, :life_changes, :week_visits, :monthly_meeting,
        candidate_educations_attributes:
            [:id, :education, :institution, :specialty, :_destroy],
        candidate_family_members_attributes:
            [:id, :name, :gender, :age, :relation, :_destroy]
      )
    end
end
