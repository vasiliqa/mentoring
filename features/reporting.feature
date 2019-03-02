Feature: Reporting
  In order to allow mentors create report and a curator read and verify it
  Mentor should send report once in a month

  Background:
    Given a orphanage "#13"
    And a child with name "Stalin" in orphanage "#13"
    And a user with email: "psych@example.com" and role "curator" for orphanage "#13"
    And a user with email: "review@example.com" and role "report_reviewer", curating orphanage "#13"
    And a user with email: "mentor@example.com" and role "mentor" for child "Stalin" and curator: "psych@example.com"

  Scenario: Send report
    Given I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
    When I go to "/reports"
    And I click to the button "Создать новый отчёт"
    And I fill in an input "report_visits_count" as "2" in the form "new_report"
    And I fill in all textarea fields with "test"
    And I choose each radio button with label "Да"
    And I choose radio button with label "Не возражаю, если мой отчет разместят в группе" in the form "new_report"
    And I click to the submit button
    Then a report should be created
    And I should be redirected to list of reports
    And the report should have state "new"

  Scenario: A curator reject report
    Given I signed in as user with email: "psych@example.com"
    And a report from user "mentor@example.com" on state "new"
    When I go to "/reports"
    And I reject a report of meeting
    Then the report should have state "rejected"

  Scenario: A reviewer reject report
    Given I signed in as user with email: "review@example.com"
    And a report from user "mentor@example.com" on state "new"
    When I go to "/reports"
    And I reject a report of meeting
    Then the report should have state "rejected"

  Scenario: Approve Report
    Given I signed in as user with email: "psych@example.com"
    And a report from user "mentor@example.com" on state "new"
    When I go to "/reports"
    And I approve a report of meeting
    Then the report should have state "approved"
