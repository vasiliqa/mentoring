class ReportsMailer < ApplicationMailer
  def new_report report
    @report = report

    mail to: report.mentor.curator.email,
         subject: "Получен новый отчёт от #{report.mentor.full_name}"
  end
end
