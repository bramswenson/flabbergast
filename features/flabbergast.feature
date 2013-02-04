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
    +--------------+--------------------------------------------------------------------------------------------------+
    |                                           There were 11 words found.                                            |
    +--------------+--------------------------------------------------------------------------------------------------+
    | AA           | rough, cindery lava [n -S]                                                                       |
    | AB           | an abdominal muscle [n -S]                                                                       |
    | AT           | in the position of [prep]                                                                        |
    | BA           | the eternal soul, in Egyptian mythology [n -S]                                                   |
    | BAT          | to hit a baseball [v BATTED, BATTING, BATS]                                                      |
    | CAB          | to take or drive a taxicab [v CABBED, CABBING, CABS]                                             |
    | CAT          | to hoist an anchor to the cathead [v CATTED, CATTING, CATS]                                      |
    | FA           | the fourth tone of the diatonic musical scale [n -S]                                             |
    | FAT          | having an abundance of flesh [adj FATTER, FATTEST] / to make {fat=adj} [v FATTED, FATTING, FATS] |
    | TA           | an expression of gratitude [n -S]                                                                |
    | TAB          | to name or designate [v TABBED, TABBING, TABS]                                                   |
    +--------------+--------------------------------------------------------------------------------------------------+
    """

