DATABASE myTestdb

MAIN
    DEFINE item_id CHAR(10),
           quantity INTEGER,
           movement_type CHAR(10)

    LET item_id = 'ITEM001'
    LET quantity = 50
    LET movement_type = 'RECEIPT'

    INSERT INTO stock_movements (item_id, quantity, movement_type, movement_date)
    VALUES (item_id, quantity, movement_type, TODAY)

    IF sqlca.sqlcode = 0 THEN
        DISPLAY "Stock movement recorded successfully"
    ELSE
        DISPLAY "Error recording stock movement: ", sqlca.sqlerrm
    END IF
END MAIN
