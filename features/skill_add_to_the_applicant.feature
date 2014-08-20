Feature: add and delete new skill for the applicant
 
  As an HR manager
  I want to add and delete new skill for the applicant

Background: applicant have been added to database, skill have been added to database
  
  Given the following applicants exist:
  | name                 | contact_information   | status     | desirable_salary |
  | Иванов Иван Иванович | Kiev, tel. 0501234567 | job search |  2000            |

  
  Given the following skills exist:
  | name    | 
  | Testing |

  And I am on the applicants page
  And I should see "Иванов Иван Иванович"

Scenario: see the applicant
  When I follow "Иванов Иван Иванович"
    And I should see "Kiev, tel. 0501234567"
    And I follow "Edit"
    Then I should see "Edit Applicant"

@javascript
Scenario: add new skill to the applicant
  When I follow "Edit"
    Then I should see "Edit Applicant"    
    Then I should not see "New skill"
    And I fill in "e2" with "New skill"
    And I press "Add Skill"
  Then I should see "New skill"


@javascript
Scenario: add existed skill from dictionary to the applicant
   When I follow "Edit"
     Then I should not see "Testing"
   When I select2 "Testing" from "e2"
     And I press "Add Skill"
   Then I should see "Testing"

@javascript
Scenario: delete skill from applicant
   When I follow "Edit"
     Then I should not see "Testing"
   When I select2 "Testing" from "e2"
    And I press "Add Skill"
   Then I should see "Testing" 
   When I follow "Delete"
   Then I should not see "Delete"   
