*&---------------------------------------------------------------------*
*&   Tennis Game Requirements Specification
*&---------------------------------------------------------------------*
*&
*& Tennis has a rather quirky scoring system, and to newcomers it
*& can be a little difficult to keep track of. The local tennis club
*& has some code that is currently being used to update the scoreboard
*& when a player scores a point. They have recently acquired two smaller
*& tennis clubs, and they each have a similar piece of code.
*&
*& You have just been employed by the tennis club, and your job is to
*& refactor all three codebases until you are happy to work with any of
*& them. The future is uncertain, new features may be needed, and you
*& want to be thoroughly on top of your game when that happens.
*&
*& Summary of Tennis scoring:
*& 1. A game is won by the first player to have won at least four points
*&    in total and at least two points more than the opponent.
*& 2. The running score of each game is described in a manner peculiar
*&    to tennis: scores from zero to three points are described as �love�,
*&    �fifteen�, �thirty�, and �forty� respectively.
*& 3. If at least three points have been scored by each player, and the
*&    scores are equal, the score is reported as �deuce�.
*& 4. If at least three points have been scored by each side and a player
*&    has one more point than his opponent, the score of the game is
*&    �advantage� for the player in the lead.
*&
*& You need only report the current score. Sets and Matches are out of scope.


CLASS ltc_tennis_test DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ts_test_case,
        p1_points TYPE i,
        p2_points TYPE i,
        score     TYPE string,
        p1_name   TYPE string,
        p2_name   TYPE string,
      END OF ts_test_case,
      tt_test_case TYPE STANDARD TABLE OF ts_test_case WITH EMPTY KEY.

    CLASS-METHODS:
      class_setup.
    CLASS-DATA:
      gt_test_cases TYPE tt_test_case.

    METHODS:
      test_score_game1 FOR TESTING,
      test_score_game2 FOR TESTING,
      test_score_game3 FOR TESTING,
      play_game
        IMPORTING
          iv_tennis_game_class   TYPE seoclsname
          iv_p1_points           TYPE i
          iv_p2_points           TYPE i
          iv_p1_name             TYPE string
          iv_p2_name             TYPE string
        RETURNING VALUE(ro_game) TYPE REF TO lif_tennis_game.
ENDCLASS.

CLASS ltc_tennis_test IMPLEMENTATION.

  METHOD class_setup.
    gt_test_cases = VALUE #(
                    ( p1_points = 0 p2_points = 0 score = |Love-All| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 1 p2_points = 1 score = |Fifteen-All| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 2 p2_points = 2 score = |Thirty-All| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 3 p2_points = 3 score = |Deuce| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 4 score = |Deuce| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 1 p2_points = 0 score = |Fifteen-Love| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 0 p2_points = 1 score = |Love-Fifteen| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 2 p2_points = 0 score = |Thirty-Love| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 0 p2_points = 2 score = |Love-Thirty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 3 p2_points = 0 score = |Forty-Love| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 0 p2_points = 3 score = |Love-Forty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 0 score = |Win for player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 0 p2_points = 4 score = |Win for player2| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 2 p2_points = 1 score = |Thirty-Fifteen| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 1 p2_points = 2 score = |Fifteen-Thirty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 3 p2_points = 1 score = |Forty-Fifteen| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 1 p2_points = 3 score = |Fifteen-Forty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 1 score = |Win for player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 1 p2_points = 4 score = |Win for player2| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 3 p2_points = 2 score = |Forty-Thirty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 2 p2_points = 3 score = |Thirty-Forty| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 2 score = |Win for player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 2 p2_points = 4 score = |Win for player2| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 4 p2_points = 3 score = |Advantage player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 3 p2_points = 4 score = |Advantage player2| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 5 p2_points = 4 score = |Advantage player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 5 score = |Advantage player2| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 15 p2_points = 14 score = |Advantage player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 14 p2_points = 15 score = |Advantage player2| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 6 p2_points = 4 score = |Win for player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 6 score = |Win for player2| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 16 p2_points = 14 score = |Win for player1| p1_name = |player1| p2_name = |player2| )
                    ( p1_points = 14 p2_points = 16 score = |Win for player2| p1_name = |player1| p2_name = |player2| )

                    ( p1_points = 6 p2_points = 4 score = |Win for One| p1_name = |One| p2_name = |player2| )
                    ( p1_points = 4 p2_points = 6 score = |Win for Two| p1_name = |player1| p2_name = |Two| )
                    ( p1_points = 6 p2_points = 5 score = |Advantage One| p1_name = |One| p2_name = |player2| )
                    ( p1_points = 5 p2_points = 6 score = |Advantage Two| p1_name = |player1| p2_name = |Two| ) ).
  ENDMETHOD.

  METHOD play_game.
    CREATE OBJECT ro_game TYPE (iv_tennis_game_class)
      EXPORTING
        iv_player1_name = iv_p1_name
        iv_player2_name = iv_p2_name.

    DO nmax( val1 = iv_p1_points
             val2 = iv_p2_points ) TIMES.
      IF sy-index <= iv_p1_points.
        ro_game->won_point( iv_p1_name ).
      ENDIF.
      IF sy-index <= iv_p2_points.
        ro_game->won_point( iv_p2_name ).
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD test_score_game1.
    LOOP AT gt_test_cases ASSIGNING FIELD-SYMBOL(<ls_test_case>).
      DATA(lo_game) = play_game( iv_tennis_game_class = |LCL_TENNIS_GAME1|
                                 iv_p1_points         = <ls_test_case>-p1_points
                                 iv_p2_points         = <ls_test_case>-p2_points
                                 iv_p1_name           = <ls_test_case>-p1_name
                                 iv_p2_name           = <ls_test_case>-p2_name ).
      cl_abap_unit_assert=>assert_equals(
                     act = lo_game->score( )
                     exp = <ls_test_case>-score
                     msg  = |Failure for test case { sy-tabix }: | &
                            |{ <ls_test_case>-p1_points }/| &
                            |{ <ls_test_case>-p2_points }=| &
                            |{ <ls_test_case>-score }|
                     quit = if_aunit_constants=>no ).
    ENDLOOP.
  ENDMETHOD.

  METHOD test_score_game2.
    LOOP AT gt_test_cases ASSIGNING FIELD-SYMBOL(<ls_test_case>).
      DATA(lo_game) = play_game( iv_tennis_game_class = |LCL_TENNIS_GAME2|
                                 iv_p1_points         = <ls_test_case>-p1_points
                                 iv_p2_points         = <ls_test_case>-p2_points
                                 iv_p1_name           = <ls_test_case>-p1_name
                                 iv_p2_name           = <ls_test_case>-p2_name ).
      cl_abap_unit_assert=>assert_equals(
                     act = lo_game->score( )
                     exp = <ls_test_case>-score
                     msg  = |Failure for test case { sy-tabix }: | &
                            |{ <ls_test_case>-p1_points }/| &
                            |{ <ls_test_case>-p2_points }=| &
                            |{ <ls_test_case>-score }|
                     quit = if_aunit_constants=>no ).
    ENDLOOP.
  ENDMETHOD.

  METHOD test_score_game3.
    LOOP AT gt_test_cases ASSIGNING FIELD-SYMBOL(<ls_test_case>).
      DATA(lo_game) = play_game( iv_tennis_game_class = |LCL_TENNIS_GAME3|
                                 iv_p1_points         = <ls_test_case>-p1_points
                                 iv_p2_points         = <ls_test_case>-p2_points
                                 iv_p1_name           = <ls_test_case>-p1_name
                                 iv_p2_name           = <ls_test_case>-p2_name ).
      cl_abap_unit_assert=>assert_equals(
                     act = lo_game->score( )
                     exp = <ls_test_case>-score
                     msg  = |Failure for test case { sy-tabix }: | &
                            |{ <ls_test_case>-p1_points }/| &
                            |{ <ls_test_case>-p2_points }=| &
                            |{ <ls_test_case>-score }|
                     quit = if_aunit_constants=>no ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
