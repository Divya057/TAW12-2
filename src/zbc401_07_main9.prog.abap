*&---------------------------------------------------------------------*
*& Report  SAPBC401_INT_S1                                             *
*&---------------------------------------------------------------------*
*&  define inteface lif_partner and implement it in lcl_carrier        *
*&                                                                     *                                  *
*&---------------------------------------------------------------------*
REPORT  zbc401_07_main9.

TYPE-POOLS icon.

INCLUDE ZBC401_07_MAIN9PAR.
INCLUDE ZBC401_07_MAIN9CAR.

DATA:
  go_carrier   TYPE REF TO lcl_carrier,
  go_airplane  TYPE REF TO lcl_airplane,
  go_cargo     TYPE REF TO lcl_cargo_plane,
  go_passenger TYPE REF TO lcl_passenger_plane,
  gv_count     TYPE i.

START-OF-SELECTION.
*******************

***** Create Carrier ******************************************
  CREATE OBJECT go_carrier
    EXPORTING
      iv_name = 'Smile&Fly-Travel'.

***** Passenger Plane *****************************************
  CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'LH BERLIN'
      iv_planetype    = '747-400'
      iv_seats        = 345
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc = 0.
    go_carrier->add_airplane( go_passenger ).
  ENDIF.

***** cargo Plane *********************************************
  CREATE OBJECT go_cargo
    EXPORTING
      iv_name         = 'US Hercules'
      iv_planetype    = '747-200F'
      iv_cargo        = 533
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
    go_carrier->add_airplane( go_cargo ).
  ENDIF.

***** output carrier (including list of airplanes) ************

* only for testing:
* call interface method for the carrier

  go_carrier->lif_partner~display_partner( ).
*  go_carrier->display_attributes( ).
