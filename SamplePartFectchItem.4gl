DATABASE myTestdb

MAIN
    DEFINE item_id CHAR(10),
           item_record RECORD
               item_id CHAR(10),
               item_name CHAR(50),
               item_description CHAR(100)

    LET item_id = 'ITEM001'

    SELECT item_id, item_name, item_description
    INTO item_record.*
    FROM item_master
    WHERE item_id = item_id

    IF sqlca.sqlcode = 0 THEN
        DISPLAY "Item ID: ", item_record.item_id
        DISPLAY "Item Name: ", item_record.item_name
        DISPLAY "Item Description: ", item_record.item_description
    ELSE
        DISPLAY "Error fetching item: ", sqlca.sqlerrm
    END IF
END MAIN
