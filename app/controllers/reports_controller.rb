class ReportsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource only: [:new]

  # GET /reports
  def index
    @reports = @reports.order updated_at: :desc
  end

  # GET /reports/1
  def show
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
    authorize! :new, @report
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  def create
    @report.state = :new
    @report.mentor_id = current_user.id
    if @report.save
      redirect_to reports_path, notice: 'Отчёт был успешно создан.'
      ReportsMailer.new_report(@report).deliver_now if @report.mentor.curator
    else
      render :new, notice: 'Не удалось создать отчёт.'
    end
  end

  # PATCH/PUT /reports/1
  def update
    @report.resend if @report.may_resend?
    if @report.update(report_params)
      redirect_to @report, notice: 'Отчёт успешно обновлён.'
    else
      render :edit, notice: 'Отчёт не удалось обновить.'
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    redirect_to reports_url, notice: 'Отчёт был успешно удалён.'
  end


  # GET /report/1/reject
  def reject
    if @report.reject and @report.save
      flash[:notice] = 'Вы отклонили отчёт.'
    else
      flash[:notice] = 'Отчёт не удалось отклонить.'
      flash[:error] = @report.errors.full_messages.first
    end

    redirect_to reports_path, flash: {error: flash[:error]}
  end

  # GET /reports/1/approve
  def approve
    if @report.approve and @report.save
      flash[:notice] = 'Вы одобрили отчёт.'
    else
      flash[:notice] = 'Отчёт не удалось одобрить.'
      flash[:error] = @report.errors.full_messages.first
    end

    redirect_to reports_path, flash: {error: flash[:error]}
  end

  private

  def report_params
    params.require(:report).permit(
      :feelings, :visits_count, :description, :difficulties, :difficulties_comment,
      :need_help, :questions, :questions_comment, :share_permission
    )
  end
end
