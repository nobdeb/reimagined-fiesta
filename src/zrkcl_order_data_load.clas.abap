CLASS zrkcl_order_data_load DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

    "Order IDs are class attributes because the same IDs
    "are required in both order_data and order_item_data

    DATA:
      mv_order_id1 TYPE sysuuid_x16,
      mv_order_id2 TYPE sysuuid_x16,
      mv_order_id3 TYPE sysuuid_x16,
      mv_order_id4 TYPE sysuuid_x16,
      mv_order_id5 TYPE sysuuid_x16.

    METHODS:
      order_data,
      order_item_data.

ENDCLASS.


CLASS zrkcl_order_data_load IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "First delete child records
    DELETE FROM zrk_ord_items.

    "Then delete parent records
    DELETE FROM zrk_ord_order.

    "Create Order test data
    order_data( ).

    "Create Order Item test data
    order_item_data( ).

    out->write( 'Order Test Data generation successful' ).

  ENDMETHOD.


  METHOD order_data.

    DATA lt_orders TYPE STANDARD TABLE OF zrk_ord_order
                   WITH EMPTY KEY.

    "Generate five Customer UUIDs
    DATA(lv_customer_id1) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_customer_id2) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_customer_id3) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_customer_id4) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_customer_id5) =
      cl_system_uuid=>create_uuid_x16_static( ).

    "Generate five Order UUIDs
    mv_order_id1 = cl_system_uuid=>create_uuid_x16_static( ).
    mv_order_id2 = cl_system_uuid=>create_uuid_x16_static( ).
    mv_order_id3 = cl_system_uuid=>create_uuid_x16_static( ).
    mv_order_id4 = cl_system_uuid=>create_uuid_x16_static( ).
    mv_order_id5 = cl_system_uuid=>create_uuid_x16_static( ).

    GET TIME STAMP FIELD DATA(ts).

    lt_orders = VALUE #(

      ( orderid      = mv_order_id1
        customerid   = lv_customer_id1
        orderdate    = '20250310'
        curr         = 'USD'
        amount       = '1200.50'
        status       = 'PRC'
        comments     = 'Order is processing'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderid      = mv_order_id2
        customerid   = lv_customer_id2
        orderdate    = '20250311'
        curr         = 'USD'
        amount       = '1850.75'
        status       = 'ONH'
        comments     = 'Order is on hold'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderid      = mv_order_id3
        customerid   = lv_customer_id3
        orderdate    = '20250312'
        curr         = 'USD'
        amount       = '2100.00'
        status       = 'RFD'
        comments     = 'Order refunded'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderid      = mv_order_id4
        customerid   = lv_customer_id4
        orderdate    = '20250313'
        curr         = 'USD'
        amount       = '2750.25'
        status       = 'PND'
        comments     = 'Payment pending'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderid      = mv_order_id5
        customerid   = lv_customer_id5
        orderdate    = '20250314'
        curr         = 'USD'
        amount       = '3200.40'
        status       = 'CMP'
        comments     = 'Order completed'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

    ).

    "Insert Orders into DB table
    INSERT zrk_ord_order FROM TABLE @lt_orders.

  ENDMETHOD.


  METHOD order_item_data.

    DATA lt_order_items TYPE STANDARD TABLE OF zrk_ord_items
                        WITH EMPTY KEY.

    "Generate five unique Order Item UUIDs
    DATA(lv_order_item_id1) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_order_item_id2) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_order_item_id3) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_order_item_id4) =
      cl_system_uuid=>create_uuid_x16_static( ).

    DATA(lv_order_item_id5) =
      cl_system_uuid=>create_uuid_x16_static( ).

    GET TIME STAMP FIELD DATA(ts).

    lt_order_items = VALUE #(

      ( orderitemid  = lv_order_item_id1
        orderid      = mv_order_id1
        productname  = 'Laptop'
        unitfield    = 'EA'
        quantity     = '2'
        cukyfield    = 'USD'
        unitprice    = '600.25'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderitemid  = lv_order_item_id2
        orderid      = mv_order_id2
        productname  = 'Monitor'
        unitfield    = 'EA'
        quantity     = '3'
        cukyfield    = 'USD'
        unitprice    = '350.50'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderitemid  = lv_order_item_id3
        orderid      = mv_order_id3
        productname  = 'Keyboard'
        unitfield    = 'EA'
        quantity     = '5'
        cukyfield    = 'USD'
        unitprice    = '85.00'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderitemid  = lv_order_item_id4
        orderid      = mv_order_id4
        productname  = 'Mouse'
        unitfield    = 'EA'
        quantity     = '4'
        cukyfield    = 'USD'
        unitprice    = '45.75'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

      ( orderitemid  = lv_order_item_id5
        orderid      = mv_order_id5
        productname  = 'Headset'
        unitfield    = 'EA'
        quantity     = '2'
        cukyfield    = 'USD'
        unitprice    = '120.50'
        createdby     = sy-uname
        createdat     = ts
        lastchangedat = sy-uname
        changedat     = ts )

    ).

    "Insert Order Items into DB table
    INSERT zrk_ord_items FROM TABLE @lt_order_items.

  ENDMETHOD.

ENDCLASS.
