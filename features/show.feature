Feature: Stories show action

    @show @anonymous
    Scenario: anonymous users can see all the data
        Given an anonymous session
        And a story exists with title: "First story", publisher: "publisher", date: "today", section: "News", tags: "red, green", intro: "Short intro", content: "Long content"
        When I go to stories page
        And I click on "First story" within the "story-item" box
        Then the current page is a "show" action
        And the page contains theses boxes within "story-item":
            | title     | First story  |
            | publisher | jonh         |
            | date      | today        |
            | section   | News         |
            | tags      | red, green   |
            | intro     | Short intro  |
            | content   | Long content |
        And there is no link with "edit" text within "story-item"
        And there is no link with "destroy" text within "story-item"

    @show @admins
    Scenario: admin users can edit data
        Given an admin session
        And a story exists with title: "First story in admin", intro: "Short intro"
        When I go to stories page
        And I click on "First story in admin" within the "story-item" box
        And I click on "edit" within the "story-item" box
        And I type "Second story" in the "story title" field
        And I type "Long intro" in the "story intro" field
        And I submit the "story" form
        Then the current page is a "show" action
        And the flash box contains "Story updated correctly."
        And the page contains theses boxes within "story-item":
            | title | Second story |
            | intro | Long intro   |

    @show @comments
    Scenario: any user can comment a story
        Given a user exists with login: "jonh", password: "jonh", admin: false
        And a story exists with title: "First story"
        And a session logged to "jonh:jonh"
        When I go to stories page
        And I click on "First story" within the "story-item" box
        And I click on "Add a new comment"
        And I type "Comment for testing" in the "content" field of the "new comment" form
        And I submit the "new comment" form
        Then the current page is a "show" action
        And I see one "comment item" box
        And the page contains theses boxes within "comment item":
            | author-name | jonh                |
            | content     | Comment for testing |
