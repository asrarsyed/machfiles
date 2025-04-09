# <- ZSH Options -> #

# General shell behavior
unsetopt beep                  # Don't beep on command input error
setopt auto_cd                 # Change to a directory if its name is typed alone
setopt glob_dots               # Include hidden files in globbing
setopt nomatch                 # Don't generate errors for unmatched glob patterns
setopt interactive_comments    # Allow comments while typing commands
setopt complete_in_word        # Complete inside a word (e.g., "file" -> "filename" on tab)
setopt equals                  # Expand =COMMAND to COMMAND pathname
setopt glob                    # Enable globbing
setopt extended_glob           # Enable extended globbing
setopt hash_cmds               # Put path in hash when each command is executed
setopt magic_equal_subst       # Allow command-line arguments to be completed after "=" (e.g., --prefix=/usr)

# <- History & Command Options -> #
HISTFILE="$HOME/.zsh_history" # The path to the history file.
HISTSIZE=100000                # The maximum number of events to save in the internal history.
SAVEHIST=100000                # The maximum number of events to save in the history file.

# History settings
setopt bang_hist               # Treat the '!' character specially during expansion
setopt append_history          # Add new entries to history file
setopt extended_history        # Record start time and elapsed time in history file
setopt inc_append_history      # Write to the history file immediately, not just when the shell exits
setopt share_history           # Share history between all sessions
setopt hist_ignore_all_dups    # Delete older command lines if they overlap
setopt hist_ignore_dups        # Do not add the same command line to history as the previous one
setopt hist_save_no_dups       # Ignore old commands that are the same when writing to history file.
setopt hist_find_no_dups       # Do not display a line previously found in history
setopt hist_ignore_space       # Don't record an entry starting with a space
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history.
setopt hist_reduce_blanks      # Remove superfluous blanks before recording entry
setopt hist_verify             # Don't execute immediately upon history expansion
setopt hist_no_store           # History commands are not registered in history

# <- Completion & History Options -> #

# Completion settings
setopt list_packed             # Compactly display completion list
setopt auto_remove_slash       # Automatically remove trailing / in completions
setopt auto_param_slash        # Automatically append trailing / in directory name to prepare for next completion
# setopt auto_param_keys         # Automatically completes bracket correspondence, etc.
setopt mark_dirs               # Append trailing / to filename expansions when they match a directory
setopt list_types              # Display file type identifier in list of possible completions (ls -F)
unsetopt menu_complete         # Don't auto-complete immediately when using menu (to avoid issues with vim plugin)

# <- Miscellaneous Options -> #

# Job control and background process management
setopt long_list_jobs          # Make internal command jobs output jobs -L by default
setopt notify                  # Notify as soon as background job finishes (don't wait for prompt)
setopt pushd_silent            # Don't show contents of directory stack on every pushd,popd

# Directory stack management
setopt auto_pushd              # Put the directory in the directory stack even when cd'ing normally
setopt pushd_ignore_dups       # Delete old duplicates in the directory stack
setopt pushdminus              # Swap + - behavior

# Security and Safety
setopt rm_star_wait            # Confirm before rm * is executed
unsetopt no_clobber              # Prevent overwriting files with > redirection

# Additional settings
setopt auto_resume             # Automatically resume suspended jobs when re-entering commands
setopt chase_links             # Symbolic links are converted to linked paths before execution
setopt path_dirs               # Find subdirectories in PATH when / is included in command name
setopt no_nomatch              # disable globbing for faster command execution
setopt sh_word_split           # faster word movement by using shell word style
setopt no_flow_control         # disable flow control (ctrl-s, ctrl-q) for faster terminal response%