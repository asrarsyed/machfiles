# <- Aliases ( Maximum 6 Character Letters ) ->

# Format to group aliases
if command -v somecommand &> /dev/null; then
    alias exampleone="somecommand -flags"
    alias exampletwo="somecommand -flags"
fi

alias reload='exec $SHELL -l'

# Remove broken symlinks
alias clsym="find -L . -name . -o -type d -prune -o -type l -exec rm {} +"

alias ywd='echo -n `pwd`|pbcopy' # copy cwd
alias ypwd='pwd && echo -n `pwd`|pbcopy' # copy and print cwd

# Open current/specified directory in finder
alias op='[[ $# -eq 0 ]] && open . || open "$@"'

# Call from ~/scripts/
alias tns="source ~/scripts/tmux-sessionizer"
alias nlof="source ~/Machfiles/scripts/fzf_listoldfiles.sh"
alias nzo="source ~/Machfiles/scripts/zoxide_openfiles_nvim.sh"
alias zsh-cleanup="source ~/Machfiles/scripts/cleanup-zwc.zsh"

# Folder Quick Access
alias des="cd ${HOME}/Desktop; ls"
alias dev="cd ${HOME}/Developer; ls"
alias doc="cd ${HOME}/Documents; ls"
alias dot="cd ${HOME}/Machfiles; ls"
alias dow="cd ${HOME}/Downloads; ls"
alias conf="cd ${HOME}/.config; ls"

# File and Directory Management
alias ln="ln -vi" # Interactive symbolic link.
alias cp="cp -vi" # Copy files and directories.
alias mv="mv -vi" # Move files and directories.
alias del="rm -v" # Remove files and directories.

# Static Nvim Config Switcher
alias nvchad="NVIM_APPNAME=NvChad nvim"
alias lazyvim="NVIM_APPNAME=LazyVim nvim"
alias kickstart="NVIM_APPNAME=kickstart nvim"
alias lunarvim="NVIM_APPNAME=nvim-LunarVim nvim"

# <- -----------------------------------X----------------------------------- ->

# Send files and directories to trash.
if command -v trash &> /dev/null; then alias rm='trash -vF'; fi # (trash -vlesyF)

# fd
if command -v fd &> /dev/null; then
    alias rmds='fd -HI --type f --glob ".DS_Store" --exec rm {} +'
    alias rmDS='fd -HI --type f --glob "{.DS_Store,._.DS_Store}" --exec rm -v {} + 2>&1 | grep -v "Permission denied"'
else
    # alias rmds='find . -type f -name ".DS_Store" -delete'
    # alias rmDS='find . -type f \( -name ".DS_Store" -o -name "._.DS_Store" \) -delete -print 2>&1 | grep -v "Permission denied"'
fi

# clear
if command -v clear &> /dev/null; then
    alias c='clear'
    alias cl='clear'
fi

# exit
if command -v exit &> /dev/null; then
    alias x='exit'
    alias :q='exit'
    alias :wq='exit'
fi

# mkdir
if command -v mkdir &> /dev/null; then
    alias mkdir='mkdir -p' # Make directories (parent_folder/folder)
    function md () { mkdir -- "$1" && cd -P -- "$1" } # Create and CD into a directory
fi

# chmod
if command -v chmod &> /dev/null; then
    alias 600='chmod 600' # Grants read and write permissions to owner, no permissions to group and others.
    alias 644='chmod 644' # Grants read and write permissions to owner, read-only permissions to group and others.
    alias 700='chmod 700' # Grants all permissions to owner, no permissions to group and others.
    alias 755='chmod 755' # Grants all permissions to owner, read and execute permissions to group and others. 
    alias 777='chmod 777' # Grants all permissions (read, write, execute) to owner, group, and others.
fi

# sudo
if command -v sudo &> /dev/null; then
    alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Reload your Terminal.'"
    alias tobash="sudo chsh $USER -s /opt/homebrew/bin/bash && echo 'Reload your Terminal.'"
    alias tofish="sudo chsh $USER -s /opt/homebrew/bin/fish && echo 'Reload your Terminal.'"
fi

# brew
if command -v brew &> /dev/null; then
    alias bbdump="brew bundle dump --describe --file=~/brewfile"  # Generate a brewfile with descriptions
    alias buubi="brew update && brew bundle install --cleanup --file=~/brewfile && brew upgrade"  # Main Command (Upgrade Formulae)
    alias buubc="brew upgrade --cask --greedy"  # Main Command (Upgrade all Casks separately)
    alias bbcuz="brew bundle cleanup --force --zap --file=~/brewfile"  # Cleanup unneeded packages aggressively
    alias bbcat="cat $HOMEBREW_BUNDLE_FILE"  # View contents of Brewfile
fi

# nvim
if command -v nvim &> /dev/null; then
    alias nv="nvim"
    alias vim="nvim"
fi

# tmux
if command -v tmux &> /dev/null; then
    alias tm='tmux'
    alias ta='tmux attach'
    alias td='tmux detach'
    alias tn='tmux new-session'
    alias tl='tmux list-sessions'
fi

# eza
if command -v eza &> /dev/null; then
    alias ls='eza --group-directories-first --icons -s name'
    alias lf='eza --group-directories-first --icons -s name -A'
    alias ll='eza --group-directories-first --icons --git -s name -lh'
    alias la='eza --group-directories-first --icons --git -s name -lha'
    alias lld="eza --group-directories-first --icons -s name -l | grep ^d"
    alias tree='ll --tree --level=2'
    alias trees='ll -abhT --level=3 -I .git --no-filesize --no-user --no-time --no-permissions'
fi

# Download
if command -v curl &> /dev/null; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif command -v wget &> /dev/null;then
  alias get='wget --continue --progress=bar --timestamping'
fi
 
# bat
if command -v bat &> /dev/null; then
  alias cat='bat -pp --theme "gruvbox-dark"'
  alias bat='bat -pp --theme "gruvbox-dark"' 
fi

# help
help() {"$@" --help 2>&1 | bat -p --language=help}
alias -g -- -h='-h 2>&1 | bat --plain --language=help'
alias -g -- --help='--help 2>&1 | bat --plain --language=help --paging=always --style=auto'

# <- -----------------------------------X----------------------------------- ->

# Bat File Preview
alias ff="fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --wrap=auto --tabs=0 --style=rule,numbers,snip,changes,header,header-filesize --line-range=:500 {}' --preview-window=65% | xargs nvim"

# TLDR  Preview 
alias tldrf="tldr --list | fzf --preview 'tldr {1} | bat --plain --style=auto' --preview-window=right,85% | xargs tldr"
