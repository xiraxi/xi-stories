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

        Scenarios:
            | page         | stories |
            | stories      | 0       |
            | drafts story | 1       |

    @create
    Scenario Outline: non admin users can not create stories
        Given <session> session
        When I go to new story page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |
