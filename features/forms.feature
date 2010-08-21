Feature: Stories forms

    @list @create @admins
    Scenario Outline: drafts do not appear in the main index, but in the drafts index
        Given an admin session
        And a section exists with name: "Main"
        When I go to new story page
        And I fill the "story" form with:
            | Title   | A new story                 |
            | Date    | today                       |
            | Section | Main                        |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I check "Flash"
        And I check "Draft"
        And I submit the "story" form
        And I go to the <page> page
        Then I see <stories> "story-item" boxes

        Scenarios:
            | page           | stories |
            | stories        | 0       |
            | drafts stories | 1       |

    @list @create @admins
    Scenario: admin users can create new stories
        Given an admin session
        And a section exists with name: "Main"
        When I go to new story page
        And I fill the "story" form with:
            | Title   | A new story                 |
            | Date    | 2010-10-10                  |
            | Section | Main                        |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I submit the "story" form
        And I go to the stories page
        Then I see one "story item" box
        And the page contains these boxes within "story item":
            | Title   | A new story                 |
            | Date    | 2010-10-10                  |
            | Section | Main                        |
            | Intro   | This a short story          |
            | Content | This story with a happy end |

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
        Then these fields have errors: Title, Section, Intro, Publisher

