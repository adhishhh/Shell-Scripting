#complex shell script that automates log file analysis and report generation
#!/bin/bash

# Define script variables
LOG_DIR="/var/log"  # Directory containing log files
REPORT_FILE="log_report.txt"  # Output report filename
DATE=$(date +%Y-%m-%d)  # Today's date

# Function to check if a file exists
function file_exists() {
  [ -f "$1" ] && return 0 || return 1
}

# Function to analyze a log file and count errors
function analyze_log() {
  local log_file="$1"
  local error_count=$(grep -c "error" "$log_file")
  echo "Log file: $log_file - Error count: $error_count" >> "$REPORT_FILE"
}

# Function to generate the report header
function generate_report_header() {
  echo "Log Analysis Report - $DATE" >> "$REPORT_FILE"
  echo "=========================" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
}

# Function to generate the report footer
function generate_report_footer() {
  echo "" >> "$REPORT_FILE"
  echo "End of Report" >> "$REPORT_FILE"
}

# Check if report file already exists and remove if so (optional for clean reports)
if file_exists "$REPORT_FILE"; then
  rm -f "$REPORT_FILE"
fi

# Generate report header
generate_report_header

# Loop through all log files in the directory
for log_file in "$LOG_DIR"/*.log; do
  # Check if file exists (handle cases where logs might be missing)
  if file_exists "$log_file"; then
    analyze_log "$log_file"
  else
    echo "Log file not found: $log_file" >> "$REPORT_FILE"
  fi
done

# Generate report footer
generate_report_footer

echo "Log analysis report generated: $REPORT_FILE"

