#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Define the path for the inhibition flag file.
INHIBIT_FILE="/tmp/hypridle_inhibit_active"
# Define a log file for debugging purposes.
LOG_FILE="/tmp/waybar_hypridle_inhibit.log"

# Find absolute paths for common commands.
RM_CMD="/usr/bin/rm"
TOUCH_CMD="/usr/bin/touch"
ECHO_CMD="/usr/bin/echo"

# Function to log messages to the debug file
log_message() {
    "${ECHO_CMD}" "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to toggle the inhibition state
toggle_inhibit() {
    log_message "Toggle function called."
    if [ -f "$INHIBIT_FILE" ]; then
        log_message "Inhibit file exists. Removing it to deactivate inhibition."
        "${RM_CMD}" "$INHIBIT_FILE"
    else
        log_message "Inhibit file does not exist. Creating it to activate inhibition."
        "${TOUCH_CMD}" "$INHIBIT_FILE"
    fi
    log_message "Finished toggling. Getting status."
    get_status # Call get_status to output the new status to Waybar
}

# Function to get the current inhibition status
get_status() {
    log_message "Get status function called."
    if [ -f "$INHIBIT_FILE" ]; then
        # Output "awake" when inhibition is active (i.e., screen stays awake)
        log_message "Inhibit file exists. Status: awake. Outputting 'awake'."
        "${ECHO_CMD}" "awake"
    else
        # Output "idle" when inhibition is inactive (i.e., idle behavior is enabled)
        log_message "Inhibit file does not exist. Status: idle. Outputting 'idle'."
        "${ECHO_CMD}" "idle"
    fi
    log_message "Exiting get_status."
}

# Process command-line arguments
log_message "Script started with argument: $1"
case "$1" in
    toggle)
        toggle_inhibit
        ;;
    status)
        get_status
        ;;
    *)
        log_message "Invalid argument: $1. Exiting."
        "${ECHO_CMD}" "Usage: $0 {toggle|status}" >&2 # Output usage to stderr
        exit 1
        ;;
esac
log_message "Script finished successfully."
