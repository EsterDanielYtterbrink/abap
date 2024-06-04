INTERFACE yif_cdd_book_information
  PUBLIC .

   METHODS get_title
      RETURNING VALUE(r_result) TYPE string.

   METHODS get_author
      RETURNING VALUE(r_result) TYPE string.

    METHODS short_description
      RETURNING VALUE(r_result) TYPE string.

ENDINTERFACE.
