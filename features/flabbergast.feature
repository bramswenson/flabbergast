Feature: flabbergast command line interface
  As a flabbergast player
  I want to play flabbergast
  So I can train my brain


  Scenario: `flabbergast`
    Given I successfully run `flabbergast`
    Then the output should contain:
    """
    4x4 Wordgrid
    ------------
    """
    And the output should contain "There were"
    And the output should contain "words found."


  @wip
  Scenario: `flabbergast -n 8`
    Given I successfully run `flabbergast -n 8`
    Then the output should contain:
    """
    8x8 Wordgrid
    ------------
    """
    And the output should contain "There were"
    And the output should contain "words found."


  @wip
  Scenario: `flabbergast -g tha_grid.txt`
    Given I write to "tha_grid.txt" with:
    """
    C|A|B
    B|A|T
    F|A|T
    """
    And I successfully run `flabbergast -g tha_grid.txt`
    Then the output should contain:
    """
    3x3 Wordgrid
    ------------
    """
    And the output should contain "There were 10 words found."
    And the output should contain:
    """
    AT
    BAT
    CAB
    CAT
    FAB
    FAT
    TAB
    """

