require 'rails_helper'

RSpec.describe MeetingsMailer, type: :mailer do
  let (:mentor) { create :user, :mentor }
  let (:child) { create :child, mentor: mentor }
  let (:meeting) { create :meeting, mentor: mentor, child: child }
  let(:mail) { MeetingsMailer.meeting_notification meeting }

  describe '#meeting_notification' do
    context 'when new meeting created' do
      it { expect(mail.to).to eql([mentor.email]) }
    end
  end
end
