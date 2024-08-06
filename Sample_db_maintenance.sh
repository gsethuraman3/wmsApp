#!/bin/bash
#Author -  Gokulakrishnan Sethuraman
# Define variables
DATABASE_USER="Sample_your_db_user"
DATABASE_PASS="Sample_your_db_pass"
DATABASE_NAME="Sample Database"
#Provide Logger path db maitainance loggers
LOG_FILE="/Sample_path/to/db_maintenance.log"
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Log start time
echo "$DATE - Starting database maintenance" >> $LOG_FILE

# Function to optimize database tables
optimize_tables() {
    echo "$DATE - Optimizing sample database tables " >> $LOG_FILE
    mysql -u $DATABASE_USER -p$DATABASE_PASS $DATABASE_NAME -e "OPTIMIZE TABLE \`$(mysql -u $DATABASE_USER -p$DATABASE_PASS -D $DATABASE_NAME -e 'SHOW TABLES;' | tail -n +2 | tr '\n' ',')\`;"
    if [ $? -eq 0 ]; then
        echo "$DATE - Table optimization successful" >> $LOG_FILE
    else
        echo "$DATE - Table optimization failed" >> $LOG_FILE
    fi
}

# Function to update database statistics
update_statistics() {
    echo "$DATE - Updating database statistics" >> $LOG_FILE
    mysql -u $DATABASE_USER -p$DATABASE_PASS $DATABASE_NAME -e "ANALYZE TABLE \`$(mysql -u $DATABASE_USER -p$DATABASE_PASS -D $DATABASE_NAME -e 'SHOW TABLES;' | tail -n +2 | tr '\n' ',')\`;"
    if [ $? -eq 0 ]; then
        echo "$DATE - Table statistics updated successfully" >> $LOG_FILE
    else
        echo "$DATE - Failed to update table statistics" >> $LOG_FILE
    fi
}

# Function to check database integrity
check_integrity() {
    echo "$DATE - Checking database integrity" >> $LOG_FILE
    mysqlcheck -u $DATABASE_USER -p$DATABASE_PASS --all-databases --check
    if [ $? -eq 0 ]; then
        echo "$DATE - Database integrity check passed" >> $LOG_FILE
    else
        echo "$DATE - Database integrity check failed" >> $LOG_FILE
    fi
}

# Main script execution
optimize_tables
update_statistics
check_integrity

# Log end time
DATE=$(date +"%Y-%m-%d %H:%M:%S")
echo "$DATE - Database maintenance completed" >> $LOG_FILE
