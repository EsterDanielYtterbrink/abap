*"* use this source file for your ABAP unit test classes
CLASS ltcl_cdd_book DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  private section.

    data o_cut type ref to YCL_CDD_BOOK.
    methods setup.
    METHODS test_author_name for testing.
    methods test_book_title for testing raising cx_static_check.
    METHODS test_number_pages FOR TESTING RAISING cx_static_check.
    METHODS test_short_description FOR TESTING RAISING cx_static_check.

endclass.


class ltcl_cdd_book implementation.

  method setup.
    o_cut = new YCL_CDD_BOOK(
            p_title = 'The Hobbit'
            p_pages = 320
            p_author = 'Tolkien'
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
   exp = 'The Hobbit is a 320 page book by Tolkien.'
   ).

  endmethod.


endclass.
