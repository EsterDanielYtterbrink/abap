CLASS ycl_cdd_tire_pressure_sensor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS pressure
      RETURNING
        value(r_pressure) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_cdd_tire_pressure_sensor IMPLEMENTATION.

  METHOD pressure.
    Data(random) = cl_abap_random_int=>create( min = 14  max = 23 ).
    r_pressure = random->get_next( ).
  ENDMETHOD.

ENDCLASS.
