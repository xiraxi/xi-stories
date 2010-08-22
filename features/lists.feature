Feature: Stories list

    @list @pagination @anonymous
    Scenario: every index page shows 5 stories per page
        Given an anonymous session
        And 10 stories exist
        When I go to the stories page
        Then I see 5 "story" boxes
        And I see the "pagination" box

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
        And the following stories exist
            | title        | section |
            | first story  | blue    |
            | second story | blue    |
            | dummy story  | white   |
        When I go to the stories page
        And I click on "blue" within the "sections" box
        Then I see these stories:
            | first story  |
            | second story |

    @list @search @anonymous
    Scenario: results can be filtered by a query text
        Given an anonymous session
        And the following stories exist
            | title  |
            | test 1 |
            | test 2 |
            | test 3 |
            | ignore |
        When I go to the stories page
        And I type "test" on the "q" field
        And I submit the "story" form
        Then I see this stories:
            | test 1 |
            | test 2 |
            | test 3 |

    @list @tags @anonymous
    Scenario: index page shows a tags cloud
        Given an anonymous session
        And the following stories exist
            | tags   |
            | red    |
            | red    |
            | green  |
            | green  |
            | orange |
            | blue   |
        When I go to the stories page
        Then I see the "tag-cloud" box with this links:
            | red    |
            | green  |
            | orange |
            | blue   |

    @list
    Scenario: index items show a reduced version of the story
        Given a user exists with login: "john", password: "john", admin: true
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
        Then the header box contains "New story"
        And the current page is a "new" action

    Scenario: admins can access to drafts index
        Given an admin session
        When I go to the stories page
        And I click on "Drafts"
        Then the header box contains "Drafts stories"
        Then I see 0 "story-item" boxes

    Scenario Outline: non admins cannot access to drafts index
        Given <session> session
        When I go to the drafts stories page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |
