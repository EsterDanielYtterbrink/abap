* All years divisible by 400 ARE leap years (so, for example, 2000 was indeed a leap year),
* All years divisible by 100 but not by 400 are NOT leap years (so, for example, 1700, 1800, and 1900 were NOT leap years, NOR will 2100 be a leap year),
* All years divisible by 4 but not by 100 ARE leap years (e.g., 2008, 2012, 2016),
* All years not divisible by 4 are NOT leap years (e.g. 2017, 2018, 2019).
*
* https://codingdojo.org/kata/LeapYears/

CLASS zcl_cdd_leap_year DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS is_leap_year
    importing
    year TYPE i
    RETURNING
    value(result) type abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cdd_leap_year IMPLEMENTATION.
    method is_leap_year.
        result = abap_false.
        if year MOD 400 = 0.
            result = abap_true.
        elseif year MOD 100 = 0.
            result = abap_false.
        elseif year MOD 4 = 0.
            result = abap_true.
        endif.
    endmethod.
ENDCLASS.
