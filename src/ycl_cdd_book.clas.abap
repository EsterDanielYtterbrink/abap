CLASS ycl_cdd_book DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING p_title  TYPE string
                p_pages  TYPE i
                p_author TYPE string.

    METHODS get_title
      RETURNING VALUE(r_result) TYPE string.

    METHODS get_pages
      RETURNING VALUE(r_result) TYPE i.

    METHODS get_author
      RETURNING VALUE(r_result) TYPE string.

    METHODS short_description
      RETURNING VALUE(r_result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA m_title TYPE string.
    DATA m_pages type i.
    DATA m_author TYPE string.
ENDCLASS.



CLASS ycl_cdd_book IMPLEMENTATION.

  METHOD get_title.
    r_result = m_title.
  ENDMETHOD.

  method get_pages.
    r_result = m_pages.
  endmethod.

  METHOD constructor.
    m_title = p_title.
    m_pages = p_pages.
    m_author = p_author.
  ENDMETHOD.

  METHOD get_author.
    r_result = m_author.
  ENDMETHOD.


  METHOD short_description.
        r_result = |{ m_title } is a { m_pages } page book by { m_author }.|.
  ENDMETHOD.

ENDCLASS.
