class ltc_cdd_leap_year definition final for testing
  duration short
  risk level harmless.

  private section.
    data o_cut type ref to zcl_cdd_leap_year.
    methods setup.
    methods regular_leap_year for testing.
    methods century_leap_year for testing.
    methods not_leap_year for testing.
    methods fourhunded_leap_year for testing.
endclass.


class ltc_cdd_leap_year implementation.

   method setup.
        o_cut = NEW zcl_cdd_leap_year( ).
   endmethod.

  method regular_leap_year.
    cl_abap_unit_assert=>assert_equals(
     	act = o_cut->is_leap_year( year = 1992 )
     	exp = abap_true
     ).
  endmethod.

  method century_leap_year.
    cl_abap_unit_assert=>assert_equals(
     	act = o_cut->is_leap_year( year = 1900 )
     	exp = abap_false
     ).
  endmethod.

  method not_leap_year.
     cl_abap_unit_assert=>assert_equals(
     	act = o_cut->is_leap_year( year = 1901 )
     	exp = abap_false
     ).
  endmethod.

  method fourhunded_leap_year.
     cl_abap_unit_assert=>assert_equals(
     	act = o_cut->is_leap_year( year = 2000 )
     	exp = abap_true
     ).
  endmethod.

endclass.
