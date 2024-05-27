CLASS ycl_cdd_book DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
        importing   p_title type string
                    p_pages type i
                    p_author type string.

    METHODS get_title
     RETURNING
        value(r_result) TYPE string.

    methods get_pages
        RETURNING
        value(r_result) type i.
    METHODS get_author
      RETURNING
        value(r_result) TYPE string.
    METHODS short_description
      RETURNING
        value(r_result) TYPE string.

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
