CLASS ycl_cdd_tire_pressure_alarm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  CONSTANTS LOW_PRESSURE_THRESHOLD TYPE i VALUE 17.
  CONSTANTS HIGH_PRESSURE_THRESHOLD TYPE i VALUE 21.

  METHODS check.
  METHODS is_on returning value(is_alarm_on) type abap_bool.
  METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA alarm_on type abap_bool.
  DATA sensor TYPE REF TO ycl_cdd_tire_pressure_sensor.

ENDCLASS.

