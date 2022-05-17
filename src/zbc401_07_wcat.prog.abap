*&---------------------------------------------------------------------*
*& Report ZBC401_07_WCAT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC401_07_WCAT.
DATA:
    go_handle    TYPE REF TO   zcl_07_area,
    go_root      TYPE REF TO   zcl_07_root,
    go_catalog   TYPE REF TO   zcl_07_catalog,

    gt_flights   TYPE          bc402_t_sdynconn.
*----------------------------------------------------------------------*
START-OF-SELECTION.


  go_handle = zcl_07_area=>attach_for_write( ).

  CREATE OBJECT go_root AREA HANDLE go_handle.
  CREATE OBJECT go_catalog AREA HANDLE go_handle.

  go_root->mo_catalog = go_catalog.


  go_handle->set_root( root = go_root ).
*
  SELECT *
      FROM spfli JOIN sflight
      ON   spfli~carrid = sflight~carrid AND
           spfli~connid = sflight~connid
      INTO CORRESPONDING FIELDS OF TABLE gt_flights.

  go_handle->root->mo_catalog->fill_catalog(
                                  it_catalog = gt_flights ).
  go_handle->detach_commit( ).
