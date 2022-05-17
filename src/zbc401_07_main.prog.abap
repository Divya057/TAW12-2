*&---------------------------------------------------------------------*
*& Report ZBC401_07_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC401_07_MAIN.

INCLUDE ZBC401_07_MAIN_PLANE.
INCLUDE ZBC401_07_MAIN_VEHICLE.

DATA: planetab TYPE TABLE OF REF TO lcl_airplane,
      r_plane  TYPE REF TO lcl_airplane.

START-OF-SELECTION.

  CREATE OBJECT r_plane.
  r_plane->set_attributes(
    EXPORTING
      i_name      = 'Airbus'
      i_planetype = 'A380-800'
  ).
  APPEND r_plane TO planetab.

  CREATE OBJECT r_plane.
  r_plane->set_attributes(
    EXPORTING
      i_name      = 'Boeing'
      i_planetype = '777-300'
  ).
  APPEND r_plane TO planetab.

  CREATE OBJECT r_plane.
  r_plane->set_attributes(
    EXPORTING
      i_name      = 'Airbus'
      i_planetype = 'A320-200'
  ).
  APPEND r_plane TO planetab.

  LOOP AT planetab INTO r_plane.
    r_plane->display_attributes( ).
  ENDLOOP.

  WRITE:/ 'The number of airplanes -', lcl_airplane=>get_n_o_airplanes( ) .
