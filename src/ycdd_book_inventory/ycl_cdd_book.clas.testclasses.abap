*"* use this source file for your ABAP unit test classes
CLASS ltcl_cdd_book DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    DATA o_cut TYPE REF TO ycl_cdd_book.

    METHODS setup.
    METHODS test_author_name       FOR TESTING.
    METHODS test_book_title        FOR TESTING RAISING cx_static_check.
    METHODS test_number_pages      FOR TESTING RAISING cx_static_check.
    METHODS test_short_description FOR TESTING RAISING cx_static_check.
    METHODS test_initial_book_count FOR TESTING RAISING cx_static_check.
    METHODS test_add_book FOR TESTING RAISING cx_static_check.
    METHODS test_borrow_book FOR TESTING RAISING cx_static_check.
    METHODS test_return_book FOR TESTING RAISING cx_static_check.
    METHODS test_borrow_unavailable_book FOR TESTING RAISING cx_static_check.

endclass.


class ltcl_cdd_book implementation.

  method setup.
    o_cut = new YCL_CDD_BOOK(
            p_title = 'The Hobbit'
            p_pages = 320
            p_author = 'Tolkien'
            p_published = 1937
        ).
  endmethod.

  method test_book_title.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->get_title( )
   exp =  'The Hobbit' ).
  endmethod.

  method test_number_pages.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->get_pages( )
   exp =  320 ).
  endmethod.

  method test_author_name.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->get_author( )
   exp =  'Tolkien' ).
  endmethod.

  method test_short_description.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->short_description( )
   exp = 'The Hobbit is a book by Tolkien first published in 1937.'
   ).
  endmethod.

  method test_initial_book_count.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->available_books( )
   exp = 0 ).
  endmethod.

  METHOD test_add_book.
    o_cut->add_book( ).
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = o_cut->available_books( ) ).
  ENDMETHOD.

  method test_borrow_book.
    o_cut->add_book( ).
    o_cut->borrow_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->available_books( )
    exp = 0 ).
  endmethod.

  method test_return_book.
    o_cut->add_book( ).
    o_cut->borrow_book( ).
    o_cut->return_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->available_books( )
    exp = 1 ).
  endmethod.

  method test_borrow_unavailable_book.
    o_cut->borrow_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->available_books( )
    exp = 0 ).
  endmethod.

endclass.
