# ---- Quiet, predictable startup ----
set confirm off
set pagination on
set startup-with-shell off
set verbose off

# ---- Source-first TUI ----
tui enable
layout src
focus cmd
set disassemble-next-line off

# ---- Better printing ----
set print pretty on
set print frame-arguments all
set print object on
set print elements 200
set print null-stop on

# ---- User-space friendly signal handling ----
handle SIGPIPE nostop noprint pass
handle SIGALRM nostop noprint pass
handle SIGUSR1 nostop noprint pass
handle SIGUSR2 nostop noprint pass

# ---- Threading ----
set print thread-events off

# ---- History ----
set history save on
set history filename ~/.gdb_history
set history size 10000

# ---- Prompt ----
# set prompt (gdb)❯ 
