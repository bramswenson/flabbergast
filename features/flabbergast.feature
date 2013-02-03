Feature: flabbergast command line interface
  As a flabbergast player
  I want to play flabbergast
  So I can train my brain


  Scenario: `flabbergast`
    Given I successfully run `flabbergast`
    Then the output should contain:
    """
    +---+---+---+---+
    | 4x4 Wordgrid  |
    +---+---+---+---+
    """
    And the output should contain "There were"
    And the output should contain "words found."


  Scenario: `flabbergast -s 8`
    Given I successfully run `flabbergast -s 8`
    Then the output should contain:
    """
    +---+---+---+---+---+---+---+---+
    |         8x8 Wordgrid          |
    +---+---+---+---+---+---+---+---+
    """
    And the output should contain "There were"
    And the output should contain "words found."


  Scenario: `flabbergast -f tha_grid.txt`
    Given I write to "tha_grid.txt" with:
    """
    CAB
    BAT
    FAT
    """
    And I successfully run `flabbergast -f tha_grid.txt`
    Then the output should contain:
    """
    +----+----+----+
    | 3x3 Wordgrid |
    +----+----+----+
    | C  | A  | B  |
    | B  | A  | T  |
    | F  | A  | T  |
    +----+----+----+
    There were 10 words found.
    AB
    AT
    BA
    BAT
    CAB
    CAT
    FA
    FAT
    TA
    TAB
    """

