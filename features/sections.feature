Feature: Story sections

    Scenario Outline: non admin users cannot open story sections index
        Given <session> session
        When I go to the new story section page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    Scenario: admin users can create story sections
        Given an admin session
        When I go to the new story section page
        And I fill in the following:
            | Name     | Test section |
            | Position | 1            |
        And I submit the form "new_story_section"
        Then a story section should exist with name: "Test section"
        And the flash box contains "Successfully created"

    Scenario: story section list is ordered by position
        Given an anonymous session
        And the following story sections exist:
            | name  | position  |
            | Green | 2         |
            | Red   | 1         |
            | Blue  | 3         |
        When I go to the stories page
        Then the "story sections" box has these boxes in the same order:
            | section  | Red   |
            | section  | Green |
            | section  | Blue  |

    Scenario: unused story sections can be removed
        Given an admin session
        And the following story sections exist:
            | name  |
            | Red   |
            | Blue  |
        When I go to the story sections page
        And I click on "Delete"
        Then the flash box contains "Successfully deleted"
        And there are no story section instances

    Scenario: used story sections can not be removed
        Given an admin session
        And a story section exists with name: "Main", id: 1
        And a story exists with section_id: 1
        When I go to the story sections page
        And I click on "Delete"
        Then the flash box contains "Could not be deleted"
        And a story section should exist with name: "Main"

