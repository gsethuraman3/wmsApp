DATABASE myTestdb

MAIN
    DEFINE item_id CHAR(10),
           item_name CHAR(50),
           item_description CHAR(100)

    LET item_id = 'ITEM001'
    LET item_name = 'Widget'
    LET item_description = 'Sample widget'

    INSERT INTO item_master (item_id, item_name, item_description)
    VALUES (item_id, item_name, item_description)

    IF sqlca.sqlcode = 0 THEN
        DISPLAY "Item inserted successfully"
    ELSE
        DISPLAY "Error inserting item: ", sqlca.sqlerrm
    END IF
END MAIN
