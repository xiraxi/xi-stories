Feature: Stories forms

    @list @create @admins
    Scenario Outline: drafts do not appear in the main index, but in the drafts index
        Given an admin session
        And the following story sections exist:
            | name  |
            | Foo   |
        When I go to the new story page
        And I fill in the following:
            | Title   | A new story                 |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I select "1980-08-19" as the "Date" date
        And I select "Foo" from "Section"
        And I check "Breaking"
        And I check "Draft"
        And I submit the form
        And I go to the <page> page
        Then I see <stories> "story" boxes

        Scenarios:
            | page           | stories |
            | stories        | 0       |
            | drafts stories | 1       |

    @list @create @admins
    Scenario: admin users can create new stories
        Given an admin session
        And the following story sections exist:
            | name  |
            | Foo   |
        When I go to the new story page
        And I fill in the following:
            | Title   | A new story                 |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I select "1980-08-19" as the "Date" date
        And I select "Foo" from "Section"
        And I submit the form
        And I go to the stories page
        Then I see 1 "story" boxes
        And I should see "A new story" within "story"

    @create
    Scenario Outline: non admin users can not create stories
        Given <session> session
        When I go to the new story page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    @create
    Scenario: stories can not be empty
        Given an admin session
        When I go to the new story page
        And I submit the form
        Then these fields have errors: Title, Intro

    @update
    Scenario Outline: only admin users can see button to update stories
      Given <session> session
      And the following story sections exist:
          | name  |
          | Foo   |
      And the following stories exist
          | title | date        | intro | content     | section_id  |
          | foo   | 2010-10-10  | Bar   | Lorem Ipsum | 1           |
      When I go to the edit story page with id: "foo"
      Then the page <verb> "Edit" 
      Scenarios:
          | session        | verb             |
          | an admin       | contains         |
          | an anonymous   | does not contain |
          | a regular user | does not contain |

    @delete
    Scenario Outline: only admin users can see button to delete stories
      Given <session> session
      And the following story sections exist:
          | name  |
          | Foo   |
      And the following stories exist
          | title | date        | intro | content     | section_id  |
          | foo   | 2010-10-10  | Bar   | Lorem Ipsum | 1           |
      When I go to the story page with id: "foo"
      Then the page <verb> "Delete" 
      Scenarios:
          | session        | verb             |
          | an admin       | contains         |
          | an anonymous   | does not contain |
          | a regular user | does not contain |

    @delete
    Scenario: admin can delete stories
        Given an admin session
        And the following story sections exist:
            | name  |
            | Foo   |
        And the following stories exist
            | title | date        | intro | content     | section_id  |
            | foo   | 2010-10-10  | Bar   | Lorem Ipsum | 1           |
        When I go to the story page with id: "foo"
        And I click on "Delete"
        Then I see the stories page
        And the flash box contains "News successfully deleted"
