DATABASE myTestdb

MAIN
    DEFINE order_id CHAR(10),
           item_record RECORD
               item_id CHAR(10),
               quantity INTEGER,
               location CHAR(20)

    DEFINE order_items DYNAMIC ARRAY OF RECORD
               item_id CHAR(10),
               quantity INTEGER,
               location CHAR(20)

    LET order_id = 'ORDER001'

    DECLARE c_order CURSOR FOR
        SELECT o.item_id, o.quantity, i.location
        FROM order_details o, inventory i
        WHERE o.item_id = i.item_id AND o.order_id = order_id

    OPEN c_order

    FETCH c_order INTO item_record.*

    WHILE sqlca.sqlcode = 0
        LET order_items = order_items || item_record.*
        FETCH c_order INTO item_record.*
    END WHILE

    CLOSE c_order

    FOR i = 1 TO ARRAY_LENGTH(order_items)
        DISPLAY order_items[i].item_id, order_items[i].quantity, order_items[i].location
    END FOR
END MAIN
