class MeetingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @meetings = @meetings.order date: :desc
  end

  def show
  end

  def new
    @children = current_user.children
  end

  def create
    @children = current_user.children
    if @meeting.save
      redirect_to @meeting, notice: 'Новая встреча назначена.'
      MeetingsMailer.meeting_notification(@meeting).deliver_later(wait_until: (@meeting.date - 1.day))
    else
      render :new, notice: 'Не удалось назначить встречу.', error: @meeting.errors[:name].first
    end
  end

  def destroy
    if @meeting.destroy
      flash[:notice] = 'Встреча была успешно удалена.'
    else
      flash[:notice] = 'Встречу не удалось удалить.'
      flash[:error] = @meeting.errors[:name].first
    end

    redirect_to meetings_url
  end

  def reopen
    if @meeting.reopen and @meeting.save
      flash[:notice] = 'Встреча была успешно переназначена.'
    else
      flash[:notice] = 'Встречу не удалось переназначить.'
      flash[:error] = @meeting.errors[:name].first
    end

    redirect_to meetings_path
  end

  def reject
    if @meeting.reject and @meeting.save
      flash[:notice] = current_user.has_role?(:mentor) ? 'Вы отказались от встречи.' : 'Вы отклонили встречу.'
    else
      flash[:notice] = 'Встречу не удалось отклонить.'
      flash[:error] = @meeting.errors[:name].first
    end

    redirect_to meetings_path
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date, :child_id, :mentor_id)
  end
end
