*&---------------------------------------------------------------------*
*& Report  SAPBC401_EVE_s2                                             *
*&---------------------------------------------------------------------*
*&       Implement Events in lcl_carrier and lcl_rental                *
*&       No "add" methods are needed any more in the main program !    *
*&---------------------------------------------------------------------*
REPORT  zbc401_07_main13.

TYPE-POOLS icon.

INCLUDE ZBC401_07_MAIN13_AGN.
*INCLUDE bc401_eve_s2_agency.
INCLUDE ZBC401_07_MAIN13_CAR.
*INCLUDE bc401_eve_s2_carrier.
INCLUDE ZBC401_07_MAIN13_RENTAL.
*INCLUDE bc401_eve_s2_rental.

DATA:
  go_vehicle   TYPE REF TO lcl_vehicle,
  go_truck     TYPE REF TO lcl_truck,
  go_bus       TYPE REF TO lcl_bus,
  go_rental    TYPE REF TO lcl_rental,
  go_passenger TYPE REF TO lcl_passenger_plane,
  go_cargo     TYPE REF TO lcl_cargo_plane,
  go_carrier   TYPE REF TO lcl_carrier,
  go_agency    TYPE REF TO lcl_travel_agency.


START-OF-SELECTION.
*******************

******* create travel_agency **********************************
  CREATE OBJECT go_agency
    EXPORTING
      iv_name = 'Travel&Smile Travel'.

******* create rental *****************************************
  CREATE OBJECT go_rental
    EXPORTING
      iv_name = 'Happy Car Rental'.
*  go_agency->add_partner( go_rental ).

******* create truck ******************************************
  CREATE OBJECT go_truck
    EXPORTING
      iv_make  = 'MAN'
      iv_cargo = 45.

******* create truck ******************************************
  CREATE OBJECT go_bus
    EXPORTING
      iv_make       = 'Mercedes'
      iv_passengers = 80.

******* create truck ******************************************
  CREATE OBJECT go_truck
    EXPORTING
      iv_make  = 'VOLVO'
      iv_cargo = 48.

***** Create Carrier ******************************************
  CREATE OBJECT go_carrier
    EXPORTING
      iv_name = 'Smile&Fly-Travel'.
*  go_agency->add_partner( go_rental ).

***** Passenger Plane *****************************************
  CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'LH BERLIN'
      iv_planetype    = '747-400'
      iv_seats        = 345
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc <> 0.
    WRITE:
     / icon_failure AS ICON,
       'Wrong plane type'.
  ENDIF.

***** cargo Plane *********************************************
  CREATE OBJECT go_cargo
    EXPORTING
      iv_name         = 'US Hercules'
      iv_planetype    = '747-200F'
      iv_cargo        = 533
    EXCEPTIONS
      wrong_planetype = 1.

  IF sy-subrc <> 0.
    WRITE:
     / icon_failure AS ICON,
       'Wrong plane type'.
  ENDIF.

******* show attributes of all partners of travel_agency ******
  go_agency->display_attributes( ).
