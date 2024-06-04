CLASS ycl_cdd_book DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.

    interfaces yif_cdd_storage_of_books.
    INTERFACES yif_cdd_book_information.

    METHODS constructor
      IMPORTING p_title  TYPE string
                p_pages  TYPE i
                p_author TYPE string
                p_published TYPE i
                p_storage type ref to yif_cdd_storage_of_books.

    METHODS get_pages
      RETURNING VALUE(r_result) TYPE i.

      METHODS required_shelf_space
      RETURNING
        value(r_result) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA m_title TYPE string.
    DATA m_pages type i.
    DATA m_author TYPE string.
    DATA m_published TYPE i.
    DATA m_storage TYPE ref to yif_cdd_storage_of_books.
ENDCLASS.

CLASS ycl_cdd_book IMPLEMENTATION.

  METHOD yif_cdd_book_information~get_title.
    r_result = m_title.
  ENDMETHOD.

  method get_pages.
    r_result = m_pages.
  endmethod.

  METHOD constructor.
    m_title = p_title.
    m_pages = p_pages.
    m_author = p_author.
    m_published = p_published.
    m_storage = p_storage.
  ENDMETHOD.

  METHOD yif_cdd_book_information~get_author.
    r_result = m_author.
  ENDMETHOD.

  METHOD yif_cdd_book_information~short_description.
        r_result = |{ m_title } is a book by { m_author } first published in { m_published }.|.
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~available_books.
        r_result = m_storage->available_books( ).
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~add_book.
        m_storage->add_book( ).
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~borrow_book.
    m_storage->borrow_book( ).
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~return_book.
    m_storage->return_book( ).
  ENDMETHOD.


  METHOD required_shelf_space.
        r_result = 2 * m_storage->get_total_books( ).
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~get_total_books.
        m_storage->get_total_books( ).
  ENDMETHOD.

ENDCLASS.
