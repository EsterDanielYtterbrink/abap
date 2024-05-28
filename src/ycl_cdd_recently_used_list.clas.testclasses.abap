class ltcl_cdd_recently_used_list definition final for testing
  duration short
  risk level harmless.

  private section.

    data o_cut type ref to YCL_CDD_RECENTLY_USED_LIST.
    methods setup.
    methods first_test for testing raising cx_static_check.

endclass.


class ltcl_cdd_recently_used_list implementation.

  method setup.
    o_cut = new YCL_CDD_RECENTLY_USED_LIST( ).
  endmethod.

  method first_test.

    cl_abap_unit_assert=>fail( 'Implement your first test here' ).
  endmethod.

endclass.
