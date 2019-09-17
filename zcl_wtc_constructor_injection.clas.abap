class ZCL_WTC_CONSTRUCTOR_INJECTION definition
  public
  final
  create public .

public section.

  methods GET_AMOUNT_IN_COINS
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  methods GET_AMOUNT_IN_NOTES
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WTC_CONSTRUCTOR_INJECTION IMPLEMENTATION.


  METHOD get_amount_in_coins.
    DATA(cash_provider) = CAST ZIF_WTC_CASH_PROVIDER( NEW ZCL_WTC_CASH_PROVIDER( ) ).
    DATA(notes) = cash_provider->get_notes( i_currency = 'EUR' ).
    SORT notes BY amount ASCENDING.

    r_value = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD notes[ 1 ]-amount ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_value = i_amount - get_amount_in_coins( i_amount ).
  ENDMETHOD.
ENDCLASS.
