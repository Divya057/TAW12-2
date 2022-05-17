*&---------------------------------------------------------------------*
*& Report ZBC401_DEMO10_00
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_07_ex28.
PARAMETERS: tname TYPE dd02l-tabname,
            limit TYPE i DEFAULT 100.
FIELD-SYMBOLS: <fs_itab>  TYPE ANY TABLE,
               <fs_wa>    TYPE any,
               <fs_field> TYPE simple.
DATA: dref TYPE REF TO data.

START-OF-SELECTION.
  CREATE DATA dref TYPE TABLE OF (tname).

  ASSIGN dref->* TO <fs_itab>.
  SELECT * FROM (tname) INTO TABLE <fs_itab> UP TO limit ROWS.
  zcl_00_headers=>write_headers( tname ).

  LOOP AT <fs_itab> ASSIGNING <fs_wa>.
    WRITE /.
    DO.
      ASSIGN COMPONENT sy-index OF STRUCTURE <fs_wa> TO <fs_field>.
      IF sy-subrc = 0.
        WRITE <fs_field>.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.
  ENDLOOP.
