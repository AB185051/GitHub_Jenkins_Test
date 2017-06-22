#! /bin/sh

sh /var/lib/jenkins/jobs/ETL-Flow/workspace/data01/home/env.sh

echo -e "\n\nScript Started On " `date` 
echo -e "Starting DevOps Case Study Execution...." 
echo -e "Starting Fastload execution..." 

## Load Flat File to Staging Table
${SCRIPT_DIR}/td_systems.fld > ${LOG_DIR}/td_systems_fld.log
if [[ $? -ne 0 ]]
 then
  echo "Load Flat File to Staging Table failed"
 else
  echo -e "Fastload execution completed successfully"
fi  

## Load Staging Table to Target Table
echo -e "Loading of data from staging to Target..." 
${SCRIPT_DIR}/td_systems_edw.btq > ${LOG_DIR}/td_systems_edw.log 
if [[ $? -ne 0 ]]
 then
  echo "Target Table Load failed"
 else
  echo -e "Target table loaded successfully"
fi 

## View Creation 
echo -e "Starting View creation..." 
${SCRIPT_DIR}/td_systems_view.btq > ${LOG_DIR}/td_systems_view.log 
if [[ $? -ne 0 ]]
 then
  echo "View Creation failed"
 else
  echo -e "View has been created successfully"
fi

echo -e "\n\nScript Completed On " `date` 
