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
        And I submit the form
        Then a story section should exist with name: "Test section"
        And the flash box contains "Section was successfully created."

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
        And I click on "Destroy"
        Then the flash box contains "Story section has been removed."
        And there are no story section instances

    Scenario: used story sections can not be removed
        Given an admin session
        And a section exists with name: "Main"
        And a story exists with section: "Main"
        When I go to the story sections page
        And I click on "Remove this section"
        Then the flash box contains "Story section can not be removed because it is used in 1 story."
        And a story section should exist with name: "Main"

