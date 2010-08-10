Feature: Stories forms

    @list @create @admins
    Scenario Outline: drafts does not appear in the main index, but in the drafts index
        Given an admin session
        And a section exists with name: "Main"
        When I go to new stories page
        And I fill the "story" form with:
            | title   | A new story                 |
            | date    | today                       |
            | section | Main                        |
            | intro   | This a short story          |
            | content | This story with a happy end |
            | flash   | checked                     |
            | draft   | checked                     |
        And I submit the "story" form
        And I go to the <page> page
        Then I see <stories> "story-item" boxes

    @list @create @admins
    Scenario: admin users can create new stories
        Given an admin session
        And a section exists with name: "Main"
        When I go to new stories page
        And I fill the "story" form with:
            | title   | A new story                 |
            | date    | 2010-10-10                  |
            | section | Main                        |
            | intro   | This a short story          |
            | content | This story with a happy end |
        And I submit the "story" form
        And I go to the stories page
        Then I see one "story item" box
        And the page contains theses boxes within "story item":
            | title   | A new story                 |
            | date    | 2010-10-10                  |
            | section | Main                        |
            | intro   | This a short story          |
            | content | This story with a happy end |

    @create
    Scenario Outline: non admin users can not create stories
        Given <session> session
        When I go to new story page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    @create
    Scenario: stories can not be empty
        Given an admin session
        When I go to new story page
        And I submit the "story" form
        Then these fields have errors: title, section, intro, publisher

