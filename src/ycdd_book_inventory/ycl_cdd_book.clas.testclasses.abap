*"* use this source file for your ABAP unit test classes
CLASS ltcl_cdd_book DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    DATA o_cut TYPE REF TO ycl_cdd_book.
    DATA storage type ref to yif_cdd_storage_of_books.

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
    METHODS test_reqired_shelf_space FOR TESTING RAISING cx_static_check.
    METHODS test_reqired_space_two_books FOR TESTING RAISING cx_static_check.
    METHODS test_space_borrowed_book FOR TESTING RAISING cx_static_check.

endclass.


class ltcl_cdd_book implementation.

  method setup.
    Data(l_storage) = new YCL_CDD_STORAGE( ).
    o_cut = new YCL_CDD_BOOK(
            p_title = 'The Hobbit'
            p_pages = 320
            p_author = 'Tolkien'
            p_published = 1937
            p_storage = l_storage
        ).
    storage = new YCL_CDD_BOOK(
            p_title = 'The Hobbit'
            p_pages = 320
            p_author = 'Tolkien'
            p_published = 1937
            p_storage = l_storage
        ).
  endmethod.

  method test_book_title.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->yif_cdd_book_information~get_title( )
   exp =  'The Hobbit' ).
  endmethod.

  method test_number_pages.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->get_pages( )
   exp =  320 ).
  endmethod.

  method test_author_name.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->yif_cdd_book_information~get_author( )
   exp =  'Tolkien' ).
  endmethod.

  method test_short_description.
   cl_abap_unit_assert=>assert_equals(
   act = o_cut->yif_cdd_book_information~short_description( )
   exp = 'The Hobbit is a book by Tolkien first published in 1937.'
   ).
  endmethod.

  method test_initial_book_count.
   cl_abap_unit_assert=>assert_equals(
   act = storage->available_books( )
   exp = 0 ).
  endmethod.

  METHOD test_add_book.
    storage->add_book( ).
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = storage->available_books( ) ).
  ENDMETHOD.

  method test_borrow_book.
    storage->add_book( ).
    storage->borrow_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = storage->available_books( )
    exp = 0 ).
  endmethod.

  method test_return_book.
    storage->add_book( ).
    storage->borrow_book( ).
    storage->return_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = storage->available_books( )
    exp = 1 ).
  endmethod.

  method test_borrow_unavailable_book.
    storage->borrow_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = storage->available_books( )
    exp = 0 ).
  endmethod.



  method test_reqired_shelf_space.
    o_cut->yif_cdd_storage_of_books~add_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->required_shelf_space( )
    exp = 2 ).
  endmethod.

  method test_reqired_space_two_books.
    o_cut->yif_cdd_storage_of_books~add_book( ).
    o_cut->yif_cdd_storage_of_books~add_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->required_shelf_space( )
    exp = 4 ).
  endmethod.

  method test_space_borrowed_book.
    o_cut->yif_cdd_storage_of_books~add_book( ).
    o_cut->yif_cdd_storage_of_books~add_book( ).
    o_cut->yif_cdd_storage_of_books~borrow_book( ).
    cl_abap_unit_assert=>assert_equals(
    act = o_cut->required_shelf_space( )
    exp = 4 ).
  endmethod.
endclass.
