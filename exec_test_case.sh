#! /bin/sh

sh /var/lib/jenkins/jobs/ETL-Flow/workspace/data01/home/env.sh

echo -e "Test Case Execution Started On" `date` > ${LOG_DIR}/exec_test_case.log
echo -e "\n==========================================\nStarting Test Case - Row Count Comparison\n==========================================" >> ${LOG_DIR}/exec_test_case.log

## Export the row counts to a file
${TEST_CASE_DIR}/export_row_counts.btq > ${LOG_DIR}/export_row_counts.log
if [[ $? -ne 0 ]]
 then
  echo "Export row count script failed. Please check log" >> ${LOG_DIR}/exec_test_case.log
  exit 99
fi

## Test Case - Row Count Comparison
${TEST_CASE_DIR}/compare_row_counts.sh >> ${LOG_DIR}/exec_test_case.log
if [[ $? -ne 0 ]]
 then
  echo -e "\n\nTest Case - Row Count Comparison failed" >> ${LOG_DIR}/exec_test_case.log
  exit 99
 else
  echo -e "\n\nTest Case - Row Count Comparison completed successfully" >> ${LOG_DIR}/exec_test_case.log
fi

## Test Case - Minus Test Comparison
echo -e "\n==========================================\nStarting Test Case - Minus Test Comparison\n==========================================" >> ${LOG_DIR}/exec_test_case.log
${TEST_CASE_DIR}/minus_comparison.btq > ${LOG_DIR}/minus_comparison.log
if [[ $? -ne 0 ]]
 then
  echo -e "\nTest Case - Minus Test Comparison failed. Please check log." >> ${LOG_DIR}/exec_test_case.log
  exit 99
 else
  echo -e "\nTest Case - Minus Test Comparison completed successfully" >> ${LOG_DIR}/exec_test_case.log
fi