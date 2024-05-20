CLASS ycl_cdd_test_sensor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_cdd_pressure.
    METHODS constructor
        IMPORTING pressure type i.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA value TYPE i.
ENDCLASS.

CLASS ycl_cdd_test_sensor IMPLEMENTATION.

  METHOD constructor.
         me->value = pressure.
  ENDMETHOD.

  METHOD yif_cdd_pressure~pressure.
        r_pressure = me->value.
  ENDMETHOD.

ENDCLASS.
