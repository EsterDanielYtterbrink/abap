INTERFACE yif_cdd_storage_of_books
  PUBLIC .
    METHODS add_book.
    METHODS borrow_book.
    METHODS return_book.
    METHODS available_books
      RETURNING
        value(r_result) TYPE i.
    methods get_total_books
     RETURNING
        value(r_result) TYPE i.
ENDINTERFACE.
