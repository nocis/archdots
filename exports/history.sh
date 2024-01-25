# -----------------------------------------------------
# History
# -----------------------------------------------------

# If not running interactively, don't do anything
# [ -z "$PS1" ] && return

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space > /dev/null 2>&1

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL="ignorespace:ignoredups"       
# no duplicate entries, but keep space-prefixed commands. (bash-sensible uses "erasedups:ignoreboth" but i think i validated this already?)


# here's the popularity amonngst other-peoples-dotfiles... (cmd: ag --nogroup --noheading --nofilename --hidden -o "HISTCONTROL.*" |  grep -E -o "(ignore|erase)[a-z:]*" | sort | uniq -c | sort -r)
#      5 ignoreboth
#      4 ignoredups
#      2 erasedups:ignoreboth
#      1 ignorespace:erasedups
#      1 ignoredups:erasedups
#      1 erasedups

export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
# up down
bind '"\e[A": history-search-backward' > /dev/null 2>&1
bind '"\e[B": history-search-forward' > /dev/null 2>&1


# System wide environment variables and startup programs should go into
# /etc/profile.  Personal environment variables and startup programs
# should go into ~/.bash_profile.  Personal aliases and functions should
# go into ~/.bashrc

# Provides prompt for non-login shells, specifically shells started
# in the X environment.

# Setting shell options:
#
# - Make bash append rather than overwrite the history on disk.
# - Allows user to edit a failed hist exp.
# - Allows user to verify the results of hist exp.
# - When changing directory small typos can be ignored by bash.
# - Chdirs into it if command is a dir.
# - Do not complete when readline buf is empty.
# - Extended glob (3.5.8.1) & find-all-glob with **.
# - Hashtable the commands!
# - Winsize.
shopt -s \
    histappend \
    histreedit \
    histverify \
    cdspell \
    autocd \
    no_empty_cmd_completion \
    extglob \
    globstar \
    checkwinsize

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Save and reload the history after each command finishes. Also look for any conflicting prompt_command definitions!!
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.

# !n： NO.n history
# !-n: last n-th history
# !!: last
# !keyword: search key word
# Ctrl + R: reverse search
# history | grep keyword 
# !$: last cmd parameters
# !^: last cmd first parameter
# !:n : last cmd n-th parameter


export TERMINAL_WORKSPACE_NAME=common
export HISTFILE=${HOME}/.myhistfile.${TERMINAL_WORKSPACE_NAME}
