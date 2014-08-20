Feature: add and delete new skill for the applicant
 
  As an HR manager
  I want to add and delete new skill for the applicant

Background: applicant have been added to database, skill have been added to database
  
  Given the following vacanies exist:
  | name                   | validity_period | salary | contact_information  |
  | Ruby developer         | 12              | 1200   | Kharkiv, 096 7325689 |

  
  Given the following skills exist:
  | name                   | 
  | Functional programming |

  And I am on the HR home page
  And I should see "Ruby developer"

Scenario: see the applicant
  When I follow "Ruby developer"
    And I should see "Kharkiv, 096 7325689"
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
     Then I should not see "Functional programming"
   When I select2 "Functional programming" from "e2"
     And I press "Add Skill"
   Then I should see "Functional programming"

@javascript
Scenario: delete skill from applicant
   When I follow "Edit"
     Then I should not see "Functional programming"
   When I select2 "Functional programming" from "e2"
    And I press "Add Skill"
   Then I should see "Functional programming" 
   When I follow "Delete"
   #And I wait for 5 seconds
   Then I should not see "Delete"   
