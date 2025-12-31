#!/bin/bash
 
# Wait for 10 minutes before starting the loop
sleep 5m
 
Jobname=DM-JOB-IMPROMPTU.HORTON-HDFS-TO-GCP-HDFS
Clustername=DMP228_HORTON
Bucket=gs://pypl-bkt-prd-row-std-lands/
 
# Loop from 1 to 30 for the day numbers
for day in {1..30}
do
    # Format the day number to always have two digits (e.g., 01, 02, ... 30)
    day_padded=$(printf "%02d" $day)
    # Construct the date string yyyy/mm/dd
    date_path="2024/09/$day_padded"
    # Construct Source and Target paths using the date
    Source="/sys/pp_dm/dm_hdp_batch/kafka_data/RISK/BLOGGING/EventLogger/HeadlessBeacon/$date_path"
    Target="/sys/pp_dm/dm_hdp_batch/kafka_data/RISK/BLOGGING/EventLogger/HeadlessBeacon/$date_path"
    # Execute the trigger job with parameters for this date
    ./trigger_job.sh -jn "$Jobname" -pt Hdfs -ds "any.any" -dn "$Clustername" -sd "$Source" -td "$Target" -fu "$Bucket"
done
 
 
# Save the script :wq
 
# Make the script executable by running: 
chmod +x run_trigger.sh
 
# Run the script: 
./run_trigger.sh
 
Note:
Above script will run only 2024/09/01 to 2024/09/30
for next run we have to update the year, month and 30/31.
Stop the script : kill -9 processID 
