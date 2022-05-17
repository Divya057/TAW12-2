*&---------------------------------------------------------------------*
*& Report  SAPBC401_ALV_T1                                             *
*&---------------------------------------------------------------------*
*& Template for first excercise on ALV-Grid                            *
*&---------------------------------------------------------------------*

REPORT  zbc401_07_alv.

************** Types and Data Definitions ************************
TYPES: ty_spfli TYPE STANDARD TABLE OF spfli
                     WITH NON-UNIQUE KEY carrid connid.

DATA ok_code TYPE sy-ucomm.

DATA: gt_spfli    TYPE ty_spfli.

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: on_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_column es_row_no,
      on_close FOR EVENT close OF cl_gui_dialogbox_container IMPORTING sender.
  PRIVATE SECTION.
    DATA: r_dialog   TYPE REF TO cl_gui_dialogbox_container,
          r_alv2     TYPE REF TO cl_gui_alv_grid,
          it_sflight TYPE TABLE OF sflight.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_double_click.
    DATA: wa_spfli TYPE spfli.

    READ TABLE gt_spfli INTO wa_spfli INDEX es_row_no-row_id.
    SELECT * FROM sflight INTO TABLE it_sflight WHERE carrid = wa_spfli-carrid AND connid = wa_spfli-connid.
    IF sy-subrc = 0.
      IF r_dialog IS NOT BOUND.
        CREATE OBJECT r_dialog EXPORTING width = 700 height = 350.
        CREATE OBJECT r_alv2 EXPORTING i_parent = r_dialog.
        r_alv2->set_table_for_first_display( EXPORTING i_structure_name = 'SFLIGHT'
                                            CHANGING it_outtab = it_sflight ).
        SET HANDLER on_close FOR r_dialog.
      ELSE.
        r_alv2->refresh_table_display( ).
      ENDIF.
    ENDIF.
*    MESSAGE i010(bc401) WITH es_row_no-row_id e_column-fieldname.
  ENDMETHOD.
  METHOD on_close.
    sender->free( ).
  ENDMETHOD.
ENDCLASS.

DATA: r_container TYPE REF TO cl_gui_custom_container,
      r_alv       TYPE REF TO cl_gui_alv_grid,
      r_handler   TYPE REF TO lcl_handler.

START-OF-SELECTION.
*********************

  SELECT * FROM spfli INTO TABLE gt_spfli.

  CALL SCREEN '0100'.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'DYNPROSTATUS'.
  SET TITLEBAR  'TITLE1'.
ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  ALV_GRID  OUTPUT
*&---------------------------------------------------------------------*
MODULE alv_grid OUTPUT.
*** Create object of class CL_GUI_CUSTOM_CAONTAINER to manage data !

  IF r_container IS NOT BOUND.
    CREATE OBJECT r_container EXPORTING container_name = 'CONTAINER_1'.
    CREATE OBJECT r_alv EXPORTING i_parent = r_container.
    r_alv->set_table_for_first_display( EXPORTING i_structure_name = 'SPFLI'
                                        changing it_outtab = gt_spfli ).
  else.
    r_alv->refresh_table_display( ).
    ENDIF.
ENDMODULE.                 " ALV_GRID  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      SET SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT
