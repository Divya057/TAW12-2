*---------------------------------------------------------------------*
*       CLASS lcl_vehicle DEFINITION
*---------------------------------------------------------------------*
CLASS lcl_vehicle DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
         IMPORTING iv_make TYPE string,
      display_attributes.

  PRIVATE SECTION.

    DATA:
      mv_make TYPE string.

ENDCLASS.                    "lcl_vehicle DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_vehicle IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_vehicle IMPLEMENTATION.

  METHOD constructor.
    mv_make = iv_make.
  ENDMETHOD.                    "constructor

  METHOD display_attributes.
    WRITE mv_make.
  ENDMETHOD.                    "display_attributes

ENDCLASS.                    "lcl_vehicle IMPLEMENTATION


*---------------------------------------------------------------------*
*       CLASS lcl_truck DEFINITION
*---------------------------------------------------------------------*
CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_make  TYPE string
          iv_cargo TYPE s_plan_car,

       display_attributes REDEFINITION.

  PRIVATE SECTION.

    DATA:
      mv_cargo TYPE s_plan_car.

ENDCLASS.                    "lcl_truck DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_truck IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_truck IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_make ).
    mv_cargo = iv_cargo.
  ENDMETHOD.                    "constructor

  METHOD display_attributes.
    WRITE / icon_ws_truck AS ICON.
    super->display_attributes( ).
    WRITE:
       20 'Max. Cargo:'(005),
          mv_cargo.
    ULINE.
  ENDMETHOD.                    "display_attributes

ENDCLASS.                    "lcl_truck IMPLEMENTATION


*---------------------------------------------------------------------*
*       CLASS lcl_bus DEFINITION
*---------------------------------------------------------------------*
CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING iv_make       TYPE string
                  iv_passengers TYPE i,

      display_attributes REDEFINITION.

  PRIVATE SECTION.

    DATA:
      mv_passengers TYPE i.

ENDCLASS.                    "lcl_bus DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_bus IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_bus IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_make ).
    mv_passengers = iv_passengers.
  ENDMETHOD.                    "constructor

  METHOD display_attributes.
    WRITE: / icon_transportation_mode AS ICON.
    super->display_attributes( ).
    WRITE:
      20 'Max. Passengers: '(006),
          mv_passengers.
    ULINE.
  ENDMETHOD.                    "display_attributes


ENDCLASS.                    "lcl_bus IMPLEMENTATION

*---------------------------------------------------------------------*
*       CLASS lcl_rental DEFINITION
*---------------------------------------------------------------------*
CLASS lcl_rental DEFINITION.

  PUBLIC SECTION.

    INTERFACES:
      lif_partner.

    METHODS:
      constructor IMPORTING iv_name TYPE string,

      add_vehicle IMPORTING io_vehicle TYPE REF TO lcl_vehicle,

      display_attributes.

  PRIVATE SECTION.

    DATA:
       mv_name TYPE string,
       mt_vehicles TYPE TABLE OF REF TO lcl_vehicle.

ENDCLASS.                    "lcl_rental DEFINITION
*---------------------------------------------------------------------*
*       CLASS lcl_rental IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_rental IMPLEMENTATION.

  METHOD  constructor.
    mv_name = iv_name.
  ENDMETHOD.                    "constructor

  METHOD  add_vehicle.
    APPEND io_vehicle TO mt_vehicles.
  ENDMETHOD.                    "add_vehicle

  METHOD  display_attributes.
    DATA:
      lo_vehicle TYPE REF TO lcl_vehicle.

    WRITE:
     / icon_transport_proposal AS ICON,
       mv_name.
    ULINE.
    ULINE.

    LOOP AT mt_vehicles INTO lo_vehicle.
      lo_vehicle->display_attributes( ).
    ENDLOOP.
  ENDMETHOD.                    "display_attributes

  METHOD lif_partner~display_partner.
    me->display_attributes( ).
  ENDMETHOD.                    "lif_partner~display_partner

ENDCLASS.                    "lcl_rental IMPLEMENTATION
