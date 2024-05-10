*"* use this source file for your ABAP unit test classes
class ltcl_cdd_tire_pressure_alarm definition final for testing
  duration short
  risk level harmless.

  private section.
    DATA o_cut type ref to  ycl_cdd_tire_pressure_alarm.
    methods:
      should_be_off_by_default for testing raising cx_static_check,
      should_be_on FOR TESTING RAISING cx_static_check,
      sould_be_off FOR TESTING RAISING cx_static_check.
endclass.


class ltcl_cdd_tire_pressure_alarm implementation.

  method should_be_off_by_default.
    o_cut = new ycl_cdd_tire_pressure_alarm( ).
    cl_abap_unit_assert=>assert_equals(
     act = o_cut->is_on( )
     exp = abap_false
     ).
  endmethod.

  method should_be_on.
    o_cut = new ycl_cdd_tire_pressure_alarm( ).
    o_cut->check( ).

    cl_abap_unit_assert=>assert_equals(
     act = o_cut->is_on( )
     exp = abap_true
     ).
  endmethod.

  method sould_be_off.
  o_cut = new ycl_cdd_tire_pressure_alarm( ).
  o_cut->check( ).

    cl_abap_unit_assert=>assert_equals(
     act = o_cut->is_on( )
     exp = abap_false
     ).
   endmethod.


endclass.
