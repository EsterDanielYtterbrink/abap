CLASS ycl_cdd_storage DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
  interfaces yif_cdd_storage_of_books.
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_available_books TYPE i.
    DATA m_total_books TYPE i.
ENDCLASS.



CLASS ycl_cdd_storage IMPLEMENTATION.

METHOD constructor.
    m_available_books = 0.
    m_total_books = 0.
endmethod.

METHOD yif_cdd_storage_of_books~available_books.
        r_result = m_available_books.
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~add_book.
        m_available_books += 1.
        m_total_books += 1.
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~borrow_book.
    IF m_available_books > 0.
      m_available_books -= 1.
    ENDIF.
  ENDMETHOD.

  METHOD yif_cdd_storage_of_books~return_book.
     m_available_books += 1.
  ENDMETHOD.

   method yif_cdd_storage_of_books~get_total_books.
        r_result = m_total_books.
   endmethod.

ENDCLASS.
