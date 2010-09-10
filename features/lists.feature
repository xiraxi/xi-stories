Feature: Stories list

    @list @pagination @anonymous
    Scenario: every index page shows 5 stories per page
        Given an anonymous session
        And 10 stories exist
        When I go to the stories page
        Then I see 5 "story" boxes
        And I see the "pagination" box

    @list
    Scenario Outline: stories are lists by lang
      Given an anonymous session
      And the following stories exist
        | title         | lang  |
        | spanish story | es    |
        | english story | en    |
      And locale is "<locale>"
      When I go to the stories page
      Then I see 1 "story" boxes

      Scenarios:
        | locale  |
        | es      |
        | en      |

    @list @tags @anonymous
    Scenario: results can be filtered by a tag
        Given an anonymous session
        And the following stories exist
            | title        | tag_list |
            | first story  | red      |
            | second story | red      |
            | dummy story  | green    |
        When I go to stories page
        And I click on "red" within the "tag-cloud" box
        Then I see this stories:
            | first story  |
            | second story |

    @list @anonymous
    Scenario: results can be filtered by a section
        Given an anonymous session
        And the following story sections exists
            | name  | id  |
            | blue  | 1   |
            | white | 2   |
        And the following stories exist
            | title        | section_id |
            | first story  | 1          |
            | second story | 1          |
            | dummy story  | 2          |
        When I go to the stories page
        And I click on "blue" within the "sections" box
        Then I see these stories:
            | first story  |
            | second story |

    @list @tags @anonymous
    Scenario: index page shows a tags cloud
        Given an anonymous session
        And the following stories exist
            | tag_list  |
            | red       |
            | red       |
            | green     |
            | green     |
            | orange    |
            | blue      |
        When I go to the stories page
        Then there is a link with "red" text within "tag-cloud"
        And there is a link with "green" text within "tag-cloud"
        And there is a link with "orange" text within "tag-cloud"
        And there is a link with "blue" text within "tag-cloud"

    @list
    Scenario: index items show a reduced version of the story
        Given a user exists with email: "john@example.com", password: "john", admin: true
        And a section exists with name: "News"
        And a story exists with title: "First story", publisher: "publisher", date: "today", section: "News", tags: "red, green", intro: "Short intro", content: "Long content"
        And a session logged to "john:john"
        When I go to the stories page
        Then I see 1 "story" box
        And the page contains these boxes within "story":
            | title     | First story  |
            | Publisher | john         |
            | Date      | today        |
            | Section   | News         |
            | Tags      | red, green   |
            | Intro     | Short intro  |
            | Content   | Long content |

    Scenario: admins can access to the new story form
        Given an admin session
        When I go to the stories page
        And I click on "New story"
        Then the current page is a "new" action

    Scenario: admins can access to drafts index
        Given an admin session
        When I go to the stories page
        And I click on "Drafts"
        Then the flash box contains "Listing drafts"
        Then I see 0 "story" boxes

    Scenario Outline: non admins cannot access to drafts index
        Given <session> session
        When I go to the drafts stories page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    Scenario: deleted stories are not shown on index
        Given an anonymous session
        And the following story sections exist:
            | name  |
            | Foo   |
        And the following stories exist
            | title | date        | intro | content     | section_id  | deleted_at  |
            | foo   | 2010-10-10  | Bar   | Lorem Ipsum | 1           | 2010-11-10  |
        When I go to the stories page
        Then I see 0 "story" boxes
