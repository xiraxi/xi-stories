Feature: Stories show action

    @show @anonymous
    Scenario: anonymous users can see all data
        Given an anonymous session
        And a user exists with email: "john@example.com", password: "john", admin: true, id: 1
        And a story section exists with name: "News", id: 1
        And a story exists with title: "First story", user_id: 1, date: "2010/01/01", section_id: 1, tag_list: "red, green", intro: "Short intro", content: "Long content"
        When I go to the stories page
        And I click on "First story"
        Then the current page is a "show" action
        And I see 1 "story" boxes
        And the page contains "First story"
        And the page contains the "text" box
        And the page does not contain the "buttons" box

    @show @admins
    Scenario: admin users can edit data
        Given an admin session
        And a story exists with title: "First story in admin", intro: "Short intro"
        When I go to the stories page
        And I click on "First story in admin"
        And I click on "Edit"
        And I fill in the following:
          | Title | Second story  |
          | Intro | Long intro    |
        And I submit the form
        Then the current page is a "show" action
        And the flash box contains "News successfully saved"
        And I see 1 "story" boxes
        And the page contains "Second story"
        And the page contains "Long intro"

    @show @comments
    Scenario: any user can comment a story
        Given a regular user session
        And a story exists with title: "First story"
        And "xi_stories" configuration for "comments" is true
        When I go to the stories page
        And I click on "First story"
        And I fill in the following:
          | Content | Comment for testing |
        And I submit the form "new comment"
        Then the current page is a "show" action
        And I see 1 "comment_item" boxes
        And the page contains "Comment for testing"

    @show @comments
    Scenario: anonymous users cannot comment a story
        Given an anonymous session
        And a story exists with title: "First story"
        And "xi_stories" configuration for "comments" is true
        When I go to the stories page
        And I click on "First story"
        Then the page does not contain the "new_comment" box

    @comments
    Scenario: user can't comment if comments are disabled
        Given a regular user session
        And a story exists with title: "foo"
        And "xi_stories" configuration for "comments" is false
        When I go to the story page with id: "foo"
        Then the page does not contain the "comments" box
