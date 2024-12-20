#!/bin/bash
##################################################################################
#########----------------------------------------------------------------#########
#######                      Command Script Logger                         #######
#########----------------------------------------------------------------#########
##################################################################################

# Path to store logging status file
FP='.log_state*'
BD="$HOME/script-logs"

# Ensure the directory exists
mkdir -p "$BD"

# Function to start logging
function log_start() {

        LOG_STATE_FILE="$BD/.log_state.$$"

        if [ ! -e "$LOG_STATE_FILE" ]; then
                touch "$LOG_STATE_FILE"
                echo -e "\033[1m\033[32m[+]\033[0m \033[1mScript logging is turned \033[32mON\033[0m."
                echo -e "\033[1m\033[32m[+]\033[0m \033[1mLOGS will be saved in \033[33m~/script-logs/LOGS_$(date +'%m%d-%H:%M:%S').txt\033[0m"


                # Start logging the script
                script -a -q "$HOME/script-logs/LOGS_$(date +'%m%d-%H:%M:%S').txt" 
        else
                echo -e "\033[1m\033[33m[*]\033[0m \033[1mLogging is already ON.\033[0m"
        fi
}

# Function to stop logging for all sessions
function log_stop() {

        # Check whether logging status files exists
        file=$(find "$BD" -name "$FP" -print -quit)

        # Remove the logging status file
        if [ -n "$file" ]; then
                find "$BD" -name "$FP" -exec rm {} \;
                SCRIPT_PIDS=($(pidof script))
                if [ ${#SCRIPT_PIDS[@]} -gt 0 ]; then
                        echo -e "\033[1m\033[31m[-]\033[0m \033[1mLogging will be stopped for all active sessions.\033[0m"
                        for pid in "${SCRIPT_PIDS[@]}"; do
                                echo -e "\033[1m\033[35m[+]\033[0m \033[1mStopped logging session with PID $pid.\033[0m" && kill "$pid" 
                        done
                        SCRIPT_PIDS=()  
                else
                        echo -e "\033[1m\033[31m[-]\033[0m \033[1mNo active logging session found.\033[0m"
                fi
        else
                echo -e "\033[1m\033[31m[-]\033[0m \033[1mLogging is \033[31mOFF\033[0m."
        fi
}
if [ -z "$LOGGING_STARTED" ]; then
        # Check whether logging status files exists
        file=$(find "$BD" -name "$FP" -print -quit) 

        # If logging status file exists, logging ENABLED
        if [ -n "$file" ]; then
                #echo "Logging"
                export LOGGING_STARTED=1
                log_start
        else
                log_stop
        fi
fi