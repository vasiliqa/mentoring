require 'rails_helper'

RSpec.describe ReportsMailer, type: :mailer do

  let(:curator) { create :user, :curator }
  let(:mentor) { create :user, :mentor, curator_id: curator.id }
  let(:report) { create :report, mentor: mentor }

  let(:mail) { ReportsMailer.new_report report }

  describe '#new_report' do
    context 'when new report created' do
      it { expect(mail.to).to eql([curator.email]) }
    end
  end
end
