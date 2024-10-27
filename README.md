# cmd_logger
## What is this?
A bash script for automating the `script` command of linux in all terminals. This script enables you to start a console command logger for every terminals you open after running `log_start`. Also, it closes all the logging sessions if you run `log_stop` and won't run a logging session unless you run `log_start` again.

## How to enable
Copy and paste the the script into the last line of your `~/.bashrc, ~/.zshrc` or whatever shell configuration/startup file you're using.

## How to use
#### 1. Reconfigure the shell configuration/startup file
After pasting the code in the configuration/startup file, run the following in the terminal
```bash
# If you're using the .bashrc
$ source ~/.bashrc
```

#### 2. Start logging
Run `log_start`
```bash
└─$ log_start
[+] Script logging is turned ON.
[+] LOGS will be saved in ~/script-logs/LOGS_1028-02:57.txt
└─-[~/script-logs] $ ls
LOGS_1028-02:57.txt
```

#### 3. Stop logging
Run `log_stop`
```bash
└─$ log_stop   
[-] Stopping logging for all active sessions...
[+] Stopped logging session with PID 1021894.
```
#### 4. Check your command console log.
Check the files created inside `~/script-logs`
