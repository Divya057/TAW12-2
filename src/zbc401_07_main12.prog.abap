*&---------------------------------------------------------------------*
*& Report  SAPBC401_EVE_S1                                             *
*&---------------------------------------------------------------------*
*&  raise event airplane_created in lcl_airplane                       *                *
*&  and handle it in lcl_carrier                                       *                                                                   *
*&                                                                     *
*&  raise event vehicle_created in lcl_vehicle                         *                *
*&  and handle it in lcl_rental                                        *                                                                   *
*&---------------------------------------------------------------------*
REPORT  zbc401_07_main12.

TYPE-POOLS icon.

INCLUDE ZBC401_07_MAIN12_AGN.
*INCLUDE bc401_eve_s1_agency.
INCLUDE ZBC401_07_MAIN12_CAR.
*INCLUDE bc401_eve_s1_carrier.
INCLUDE ZBC401_07_MAIN12_RENTAL.
*INCLUDE bc401_eve_s1_rental.

DATA:
  go_vehicle   TYPE REF TO lcl_vehicle,
  go_truck     TYPE REF TO lcl_truck,
  go_bus       TYPE REF TO lcl_bus,
  go_rental    TYPE REF TO lcl_rental,
  go_agency    TYPE REF TO lcl_travel_agency,
  go_carrier   TYPE REF TO lcl_carrier,
  go_airplane  TYPE REF TO lcl_airplane,
  go_cargo     TYPE REF TO lcl_cargo_plane,
  go_passenger TYPE REF TO lcl_passenger_plane,
  gv_count     TYPE i.

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

***** Insert rental company into partner list of travel agency
  go_agency->add_partner( go_rental ).

******* create truck ******************************************
  CREATE OBJECT go_truck
    EXPORTING
      iv_make  = 'MAN'
      iv_cargo = 45.

*   go_rental->add_vehicle( go_truck ).
******* create truck ******************************************
  CREATE OBJECT go_bus
    EXPORTING
      iv_make       = 'Mercedes'
      iv_passengers = 80.
*   go_rental->add_vehicle( go_bus ).

******* create truck ******************************************
  CREATE OBJECT go_truck
    EXPORTING
      iv_make  = 'VOLVO'
      iv_cargo = 48.
*   go_rental->add_vehicle( go_truck ).

***** Create Carrier ******************************************
  CREATE OBJECT go_carrier
    EXPORTING
      iv_name = 'Smile&Fly-Travel'.

***** Insert carrier into business partner list of travel agency
  go_agency->add_partner( go_carrier ).

***** Passenger Plane *****************************************
  CREATE OBJECT go_passenger
    EXPORTING
      iv_name         = 'LH BERLIN'
      iv_planetype    = '747-400'
      iv_seats        = 345
    EXCEPTIONS
      wrong_planetype = 1.
  IF sy-subrc = 0.
*   go_carrier->add_airplane( go_passenger ).
  ELSE.
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
  IF sy-subrc = 0.
*   go_carrier->add_airplane( go_cargo ).
  ELSE.
    WRITE:
     / icon_failure AS ICON,
       'Wrong plane type'.
  ENDIF.

******* show attributes of all partners of travel_agency ******
  go_agency->display_attributes( ).
