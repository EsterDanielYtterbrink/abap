
CLASS ycl_cdd_tire_pressure_alarm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  CONSTANTS LOW_PRESSURE_THRESHOLD TYPE i VALUE 17.
  CONSTANTS HIGH_PRESSURE_THRESHOLD TYPE i VALUE 21.

  METHODS check.
  METHODS is_on returning value(is_alarm_on) type abap_bool.
  METHODS constructor
    IMPORTING sensor TYPE REF TO yif_cdd_pressure.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA alarm_on type abap_bool.
  DATA sensor TYPE REF TO yif_cdd_pressure.

ENDCLASS.



CLASS YCL_CDD_TIRE_PRESSURE_ALARM IMPLEMENTATION.


  METHOD is_on.
        is_alarm_on = me->alarm_on.
  ENDMETHOD.


  METHOD constructor.
        me->alarm_on = abap_false.
        me->sensor = sensor.
  ENDMETHOD.


  METHOD check.
    Data(reading) = me->sensor->pressure( ).
    me->alarm_on = abap_false.
   IF reading > HIGH_PRESSURE_THRESHOLD or reading < LOW_PRESSURE_THRESHOLD.
    me->alarm_on = abap_true.
   ENDIF.
  ENDMETHOD.
ENDCLASS.
