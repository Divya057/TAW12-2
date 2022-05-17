class ZCL_07_HOTEL definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_BEDS type I .
  methods DISPLAY_ATTRIBUTES .
  class-methods DISPLAY_N_O_HOTELS .
protected section.
private section.

  constants C_POS_1 type I value 30 ##NO_TEXT.
  data MV_NAME type STRING .
  data MV_BEDS type I .
  class-data GV_N_O_HOTELS type I .
ENDCLASS.



CLASS ZCL_07_HOTEL IMPLEMENTATION.


  method CONSTRUCTOR.
    mv_name = iv_name.
    mv_beds = iv_beds.
    ADD 1 TO gv_n_o_hotels.
  endmethod.


  method DISPLAY_ATTRIBUTES.
     WRITE:/ 'Welcome to the Hotel -', AT c_pos_1 mv_name,
                                    /, AT c_pos_1 mv_beds.
  endmethod.


  method DISPLAY_N_O_HOTELS.
    WRITE:/ 'The number of hotels -', gv_n_o_hotels.
  endmethod.
ENDCLASS.
