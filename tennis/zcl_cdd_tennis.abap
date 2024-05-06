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

PROGRAM yy_pao_tennis_game.


*& Production Code
INTERFACE lif_tennis_game.
  METHODS:
    won_point
      IMPORTING iv_player_name TYPE string,
    score
      RETURNING VALUE(rv_score) TYPE string.
ENDINTERFACE.


*& Production Code - Implementation Version #1
CLASS lcl_tennis_game1 DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES:
      lif_tennis_game.
    METHODS:
      constructor
        IMPORTING
           iv_player1_name TYPE string
           iv_player2_name TYPE string.

  PRIVATE SECTION.
    DATA:
      mv_score1 TYPE i VALUE 0,
      mv_score2 TYPE i VALUE 0,
      mv_player1_name TYPE string,
      mv_player2_name TYPE string.
ENDCLASS.

CLASS lcl_tennis_game1 IMPLEMENTATION.

  METHOD constructor.
    mv_player1_name = iv_player1_name.
    mv_player2_name = iv_player2_name.
  ENDMETHOD.

  METHOD lif_tennis_game~won_point.
    IF iv_player_name = mv_player1_name.
      mv_score1 = mv_score1 + 1.
    ELSE.
      mv_score2 = mv_score2 + 1.
    ENDIF.
  ENDMETHOD.

  METHOD lif_tennis_game~score.
    rv_score = VALUE #( ).
    DATA(lv_temp_score) = 0.
    IF mv_score1 = mv_score2.

      CASE mv_score1.
        WHEN 0.
          rv_score = |Love-All|.
        WHEN 1.
          rv_score = |Fifteen-All|.
        WHEN 2.
          rv_score = |Thirty-All|.
        WHEN OTHERS.
          rv_score = |Deuce|.
      ENDCASE.

    ELSEIF mv_score1 >= 4 OR mv_score2 >= 4.

      DATA(lv_minus_result) = mv_score1 - mv_score2.
      IF lv_minus_result = 1.
        rv_score = |Advantage { mv_player1_name }|.
      ELSEIF lv_minus_result = -1.
        rv_score = |Advantage { mv_player2_name }|.
      ELSEIF lv_minus_result >= 2.
        rv_score = |Win for { mv_player1_name }|.
      ELSE.
        rv_score = |Win for { mv_player2_name }|.
      ENDIF.

    ELSE.

      DO 2 TIMES.
        IF sy-index = 1.
          lv_temp_score = mv_score1.
        ELSE.
          rv_score = rv_score && |-|.
          lv_temp_score = mv_score2.
        ENDIF.
        CASE lv_temp_score.
          WHEN 0.
            rv_score = rv_score && |Love|.
          WHEN 1.
            rv_score = rv_score && |Fifteen|.
          WHEN 2.
            rv_score = rv_score && |Thirty|.
          WHEN 3.
            rv_score = rv_score && |Forty|.
        ENDCASE.
      ENDDO.

    ENDIF.
  ENDMETHOD.

ENDCLASS.


*& Production Code - Implementation Version #2
CLASS lcl_tennis_game2 DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES:
      lif_tennis_game.
    METHODS:
      constructor
        IMPORTING
          iv_player1_name TYPE string
          iv_player2_name TYPE string,
      set_p1_score
        IMPORTING
          iv_number TYPE i,
      set_p2_score
        IMPORTING
          iv_number TYPE i,
      p1_score,
      p2_score.

    DATA:
      mv_p1_point TYPE i VALUE 0,
      mv_p2_point TYPE i VALUE 0,
      mv_p1_res   TYPE string,
      mv_p2_res   TYPE string.

  PRIVATE SECTION.
    DATA:
      mv_player1_name TYPE string,
      mv_player2_name TYPE string.
ENDCLASS.

CLASS lcl_tennis_game2 IMPLEMENTATION.

  METHOD constructor.
    mv_player1_name = iv_player1_name.
    mv_player2_name = iv_player2_name.
  ENDMETHOD.

  METHOD lif_tennis_game~score.
    IF mv_p1_point = mv_p2_point AND mv_p1_point < 4.

      IF mv_p1_point = 0.
        rv_score = |Love|.
      ENDIF.
      IF mv_p1_point = 1.
        rv_score = |Fifteen|.
      ENDIF.
      IF mv_p1_point = 2.
        rv_score = |Thirty|.
      ENDIF.
      rv_score = rv_score && |-All|.

    ENDIF.
    IF mv_p1_point = mv_p2_point AND mv_p1_point >= 3.
      rv_score = |Deuce|.
    ENDIF.

    CLEAR mv_p1_res.
    CLEAR mv_p2_res.
    IF mv_p1_point > 0 AND mv_p2_point = 0.

      IF mv_p1_point = 1.
        mv_p1_res = |Fifteen|.
      ENDIF.
      IF mv_p1_point = 2.
        mv_p1_res = |Thirty|.
      ENDIF.
      IF mv_p1_point = 3.
        mv_p1_res = |Forty|.
      ENDIF.

      mv_p2_res = |Love|.
      rv_score = mv_p1_res && |-| && mv_p2_res.

    ENDIF.
    IF mv_p2_point > 0 AND mv_p1_point = 0.

      IF mv_p2_point = 1.
        mv_p2_res = |Fifteen|.
      ENDIF.
      IF mv_p2_point = 2.
        mv_p2_res = |Thirty|.
      ENDIF.
      IF mv_p2_point = 3.
        mv_p2_res = |Forty|.
      ENDIF.

      mv_p1_res = |Love|.
      rv_score = mv_p1_res && |-| && mv_p2_res.

    ENDIF.

    IF mv_p1_point > mv_p2_point AND mv_p1_point < 4.

      IF mv_p1_point = 2.
        mv_p1_res = |Thirty|.
      ENDIF.
      IF mv_p1_point = 3.
        mv_p1_res = |Forty|.
      ENDIF.
      IF mv_p2_point = 1.
        mv_p2_res = |Fifteen|.
      ENDIF.
      IF mv_p2_point = 2.
        mv_p2_res = |Thirty|.
      ENDIF.
      rv_score = mv_p1_res && |-| && mv_p2_res.

    ENDIF.
    IF mv_p2_point > mv_p1_point AND mv_p2_point < 4.

      IF mv_p2_point = 2.
        mv_p2_res = |Thirty|.
      ENDIF.
      IF mv_p2_point = 3.
        mv_p2_res = |Forty|.
      ENDIF.
      IF mv_p1_point = 1.
        mv_p1_res = |Fifteen|.
      ENDIF.
      IF mv_p1_point = 2.
        mv_p1_res = |Thirty|.
      ENDIF.
      rv_score = mv_p1_res && |-| && mv_p2_res.

    ENDIF.

    IF mv_p1_point > mv_p2_point AND mv_p2_point >= 3.

      rv_score = |Advantage { mv_player1_name }|.

    ENDIF.

    IF mv_p2_point > mv_p1_point AND mv_p1_point >= 3.

      rv_score = |Advantage { mv_player2_name }|.

    ENDIF.

    IF mv_p1_point >= 4 AND mv_p2_point >= 0 AND ( mv_p1_point - mv_p2_point ) >= 2.

      rv_score = |Win for { mv_player1_name }|.

    ENDIF.

    IF mv_p2_point >= 4 AND mv_p1_point >= 0 AND ( mv_p2_point - mv_p1_point ) >= 2.

      rv_score = |Win for { mv_player2_name }|.

    ENDIF.
  ENDMETHOD.

  METHOD set_p1_score.
    DO iv_number TIMES.
      p1_score( ).
    ENDDO.
  ENDMETHOD.

  METHOD set_p2_score.
    DO iv_number TIMES.
      p2_score( ).
    ENDDO.
  ENDMETHOD.

  METHOD p1_score.
    mv_p1_point = mv_p1_point + 1.
  ENDMETHOD.

  METHOD p2_score.
    mv_p2_point = mv_p2_point + 1.
  ENDMETHOD.

  METHOD lif_tennis_game~won_point.
    IF iv_player_name = mv_player1_name.
      set_p1_score( 1 ).
    ELSE.
      set_p2_score( 1 ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.


*& Production Code - Implementation Version #3
CLASS lcl_tennis_game3 DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES:
      lif_tennis_game.
    METHODS:
      constructor
        IMPORTING
           iv_player1_name TYPE string
           iv_player2_name TYPE string.

  PRIVATE SECTION.
    DATA:
      mv_p2  TYPE i,
      mv_p1  TYPE i,
      mv_p1n TYPE string,
      mv_p2n TYPE string.
ENDCLASS.

CLASS lcl_tennis_game3 IMPLEMENTATION.

  METHOD constructor.
    mv_p1n = iv_player1_name.
    mv_p2n = iv_player2_name.
    mv_p1  = 0.
    mv_p2  = 0.
  ENDMETHOD.

  METHOD lif_tennis_game~score.
    IF mv_p1 < 4 AND mv_p2 < 4 AND ( mv_p1 + mv_p2 ) < 6.
      DATA(lt_p) = VALUE table_of_strings(
                     ( |Love| ) ( |Fifteen| ) ( |Thirty| ) ( |Forty| ) ).
      rv_score = lt_p[ mv_p1 + 1 ].
      rv_score = COND #( WHEN mv_p1 = mv_p2
                         THEN rv_score && |-All|
                         ELSE rv_score && |-| && lt_p[ mv_p2 + 1 ] ).
    ELSE.
      IF mv_p1 = mv_p2.
        rv_score = |Deuce|.
      ELSE.
        rv_score = COND #( WHEN mv_p1 > mv_p2
                           THEN mv_p1n
                           ELSE mv_p2n ).
        rv_score = COND #( WHEN ( mv_p1 - mv_p2 ) * ( mv_p1 - mv_p2 ) = 1
                           THEN |Advantage | && rv_score
                           ELSE |Win for | && rv_score ).
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD lif_tennis_game~won_point.
    IF iv_player_name = mv_p1n.
      mv_p1 = mv_p1 + 1.
    ELSE.
      mv_p2 = mv_p2 + 1.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
