Then /^I fill in an input "(.+)" as "(.+)" in the form "(.+)"$/ do |input, value, form_id|
  within "form##{form_id}" do
    fill_in input, with: value
  end
end

When(/^I choose radio button with label "(.+)" in the form "(.+)"$/) do |label, form_id|
  within "form##{form_id}" do
    choose(label)
  end
end

Then /^a report should be created$/ do
  expect(Report.last).to_not eq(nil)
end

Given /^a report from user "(.+)" on state "new"$/ do |email|
  Report.create! do |report|
    report.mentor_id = User.find_by_email(email).id
    report.feelings = 'something'
    report.visits_count = 4
    report.description = 'something'
    report.share_permission = true
  end
end

When /^I reject a report of meeting$/ do
  find(:link_or_button, 'Отклонить').click
end

Then /^the report should have state "(.+)"$/ do |state|
  expect(Report.last.state).to eq(state)
end

When /^I approve a report of meeting$/ do
  find(:link_or_button, 'Одобрить').click
end

Then /^I should be redirected to list of reports$/ do
  expect(current_path).to eq(reports_path)
end
