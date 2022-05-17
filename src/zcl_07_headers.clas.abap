class ZCL_07_HEADERS definition
  public
  create public .

public section.

*"* public components of class ZCL_07_HEADERS
*"* do not include other source files here!!!
  class-methods WRITE_HEADERS
    importing
      !IV_TABNAME type CSEQUENCE
    exceptions
      TYPE_NOT_FOUND
      NO_STRUCTURE
      NO_DDIC_TYPE .
protected section.
*"* protected components of class CL_BC402_DYS_GENERIC_WRITE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_BC402_DYS_RTTI_HEADERS
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_07_HEADERS IMPLEMENTATION.


METHOD WRITE_HEADERS.
  DATA: r_type TYPE REF TO cl_abap_typedescr,
        r_str  TYPE REF TO cl_abap_structdescr,
        flist  TYPE ddfields.
  FIELD-SYMBOLS <fs> TYPE LINE OF ddfields.

  r_type = cl_abap_typedescr=>describe_by_name( iv_tabname ).
  IF r_type->kind NE cl_abap_typedescr=>kind_struct.
    RAISE no_structure.
  ELSE.
    r_str ?= r_type.
  ENDIF.
  flist = r_str->get_ddic_field_list( ).

  LOOP AT flist ASSIGNING <fs>.
    WRITE AT (<fs>-outputlen) <fs>-reptext.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
