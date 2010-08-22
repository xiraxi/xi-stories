Feature: Stories forms

    @list @create @admins
    Scenario Outline: drafts do not appear in the main index, but in the drafts index
        Given an admin session
        When I go to the new story page
        And I fill in the following:
            | Title   | A new story                 |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I select "1980-08-19" as the "Date" date
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
        When I go to the new story page
        And I fill in the following:
            | Title   | A new story                 |
            | Intro   | This a short story          |
            | Content | This story with a happy end |
        And I select "1980-08-19" as the "Date" date
        And I submit the form
        And I go to the stories page
        Then I see one "story item" box
        And the page contains these boxes within "story item":
            | Title   | A new story                 |
            | Date    | 2010-10-10                  |
            | Intro   | This a short story          |
            | Content | This story with a happy end |

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

