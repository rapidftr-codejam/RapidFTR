Feature: Disable and enable forms
  In order to customise the view
  As an admin user
  wants to be able to enable and disable particular forms

  Scenario Outline: Register new disable_and_enable_forms
    Given I am logged in
    And I am on the form section page
    Then the "<checkbox_id>" checkbox <has_this_value>
  Examples:
    |name             |order        |unique_id        |enabled|checkbox_id|has_this_value         |
    |Basic details    |1            |basic_details    |true   |Basic details       | should be checked     |
    |Caregiver details|2            |caregiver_details|false  | test      | should_not be checked |

   

