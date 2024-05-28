

CLASS ycl_cdd_tire_pressure_sensor DEFINITION
  PUBLIC
  FINAL.

  PUBLIC SECTION.

  INTERFACES yif_cdd_pressure.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_CDD_TIRE_PRESSURE_SENSOR IMPLEMENTATION.


  METHOD yif_cdd_pressure~pressure.
     Data(random) = cl_abap_random_int=>create( min = 14  max = 23 ).
    r_pressure = random->get_next( ).
  ENDMETHOD.
ENDCLASS.
