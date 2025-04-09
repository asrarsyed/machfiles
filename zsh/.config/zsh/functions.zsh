# <- Functions ( Minimum 5 Character Letters ) ->

# Quick access to configuration files
function conf() {
  case $1 in
    git)      $EDITOR "$HOME/.gitconfig" ;;
    gign)     $EDITOR "$HOME/.gitignore_global" ;;
    zsh)      $EDITOR "$HOME/.config/zsh/.zshrc" ;;
    vim)      $EDITOR "$HOME/.vimrc" ;;
    tmux)     $EDITOR "$HOME/.tmux.conf" ;;
    nvim)     $EDITOR "$HOME/.config/nvim/init.lua" ;;
    lvim)     $EDITOR "$HOME/.config/lvim/config.lua" ;;
  esac
}

# Automatically move into the directory when exiting yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Get Bundle ID of macOS app
function bundleid() {
  local ID=$( osascript -e 'id of app "'"$1"'"' )
  if [ ! -z $ID ]; then
    echo $ID | tr -d '[:space:]' | pbcopy
    echo "$ID (copied to clipboard)"
  fi
}

# Lazy Load Miniforge Conda/Mamba
conda() {
  unfunction conda
  eval "$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook')"
  conda "$@"
}

mamba() {
  unfunction mamba
  eval "$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook')"
  mamba "$@"
}

# Counts the lines of code for each language in the directory. (Usage: loc py js css)
function loc() {
  local total=0
  local ext
  local lines
  
  for ext in "$@"; do
    # Ensure the extension starts with a dot (e.g., ".py" instead of "py").
    [[ $ext != .* ]] && ext=".$ext"
    
    # Find all files matching the extension, output their contents, and count lines.
    lines=$(find . -name "*$ext" -exec cat {} + | wc -l | tr -d ' ')
    total=$((total + lines))
    
    # Print the line count for the current extension.
    echo "Lines of code for ${fg[blue]}$ext${reset_color}: ${fg[green]}$lines${reset_color}"
  done
  
  # Print the total line count.
  echo "${fg[blue]}Total${reset_color} lines of code: ${fg[green]}$total${reset_color}"
}

# Extracts files based on their relative extension.
function extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
         if [ $? -eq 0 ]; then
            echo "Extraction complete!"
         fi
     else
         echo "'$1' is not a valid file"
     fi
}

# function to copy output of command to system clipboard
function copy() {
  local output
  if output=$(eval "$@" 2>/dev/null); then
    echo "$output" | pbcopy && echo "  Output copied to clipboard."
  else
    echo "  Command execution failed."
  fi
}

# Display the directories listed in the $PATH variable 
function paths {
    echo -e "Index\tPath"
    echo $PATH | tr ':' '\n' | nl -w 1 -s $'\t' | awk '{printf "%-8s%s\n", "  "$1, $2}'
}

# Display the directories listed in the $FPATH variable
function fpaths {
    echo -e "Index\tPath"
    echo $FPATH | tr ':' '\n' | nl -w 1 -s $'\t' | awk '{printf "%-8s%s\n", "  "$1, $2}'
}

# Time shell startup
function startuptime {
    # Initial "cold" run
    local cold=$((TIMEFMT='%mE'; time zsh -i -c exit) 2>/dev/stdout >/dev/null)
    cold=${cold//[ms]/}
    printf "Cold start: %s ms\n\n" $cold
    
    # Warm runs
    local total=0
    printf "Warm starts:\n"
    for i in {1..10}; do
        local ms=$((TIMEFMT='%mE'; time zsh -i -c exit) 2>/dev/stdout >/dev/null)
        ms=${ms//[ms]/}
        printf "%2d: %s ms\n" $i $ms
        (( total += ms ))
    done
    
    printf "\nAverage warm start: %.2f ms\n" $(( total / 10.0 ))
}

# Compares startup times of user’s zsh vs default
function zsh-startuptime-slower-than-default {
	local time_rc
	time_rc=$((TIMEFMT="%mE"; time zsh -i -c exit) &> /dev/stdout)
	# time_norc=$((TIMEFMT="%mE"; time zsh -df -i -c exit) &> /dev/stdout)
	# compinit is slow
	local time_norc
	time_norc=$((TIMEFMT="%mE"; time zsh -df -i -c "autoload -Uz compinit && compinit -C; exit") &> /dev/stdout)
	echo "my zshrc: ${time_rc}\ndefault zsh: ${time_norc}\n"

	local result
	result=$(scale=3 echo "${time_rc%ms} / ${time_norc%ms}" | bc)
	echo "${result}x slower your zsh than the default."
}

# Time shell startup
function timezsh {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Profile shell startup
function zshprofiler {
	ZSHRC_PROFILE=1 zsh -i -c zprof
}

# Dynamic Nvim Config Switcher
function nvims {
  items=("default" "custom" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# Calculates neovim startup time & averages the results
function nvim-startuptime {
	local file=$1
	local total_msec=0
	local msec
	local i
	for i in $(seq 1 10); do
		msec=$({(TIMEFMT='%mE'; time nvim --headless -c q $file ) 2>&3;} 3>/dev/stdout >/dev/null)
		msec=$(echo $msec | tr -d "ms")
		echo "${(l:2:)i}: ${msec}"
		total_msec=$(( $total_msec + $msec ))
	done
	local average_msec
	average_msec=$(( ${total_msec} / 10 ))
	echo "\naverage: ${average_msec} [ms]"
}

# Profiles neovim startup time & shows 20 slowest steps
function nvim-profiler {
	local file=$1
	local time_file
	time_file=$(mktemp --suffix "_nvim_startuptime.txt")
	echo "output: $time_file"
	time nvim --headless --startuptime $time_file -c q $file
	tail -n 1 $time_file | cut -d " " -f1 | tr -d "\n" && echo " [ms]\n"
	cat $time_file | sort -n -k 2 | tail -n 20
}

# Compares custom neovim startup time to the default configuration.
function nvim-startuptime-slower-than-default {
	local file=$1
	local time_file_rc
	time_file_rc=$(mktemp --suffix "_nvim_startuptime_rc.txt")
	local time_rc
	time_rc=$(nvim --headless --startuptime ${time_file_rc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_rc} | cut -d " " -f1)

	local time_file_norc
	time_file_norc=$(mktemp --suffix "_nvim_startuptime_norc.txt")
	local time_norc
	time_norc=$(nvim --headless --noplugin -u NONE --startuptime ${time_file_norc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_norc} | cut -d " " -f1)

	echo "my neovim: ${time_rc}ms\ndefault neovim: ${time_norc}ms\n"
	local result
	result=$(scale=3 echo "${time_rc} / ${time_norc}" | bc)
	echo "${result}x slower your Neovim than the default."
}

# See network ip
function show_ip {
  ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
  echo $ip
}

# Quickly determine total size of a file or directory
function show_size() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# <- -----------------------------------X----------------------------------- ->

# Clone a Repo and Move into It
takegit () {
  git clone $1
  cd $(basename ${1%%.git})
}

# Make a Folder and Move into It
take () {
  if [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit $1
  else
    takedir $1
  fi
}

# <- -----------------------------------X----------------------------------- ->

function fzim(){
  local file=$(find . | fzf --multi --reverse) #get file from fzf
  if [[ $file ]]; then
    for prog in $(echo $file); #open all the selected files
    do; nvim $prog; done;
  fi
}

# Shows env
function fzenv() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}

# <- -----------------------------------X----------------------------------- ->

# Efficient helper function for RAM calculation
function _calcram() {
  local app="$1"
  # Extract the RSS (Resident Set Size) in kilobytes and convert to MB
  ps aux | grep -i "$app" | grep -v grep | awk '{sum+=$6} END {print sum / 1024}'
}

# One-time RAM usage check
function ram() {
  local app="$1"
  local sum

  if [ -z "$app" ]; then
    echo "Usage: ram <pattern>"
    return 1
  fi

  sum=$(_calcram "$app")
  if [[ "$sum" != "0" ]]; then
    echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MB of RAM"
  else
    echo "No active processes matching pattern '${fg[blue]}${app}${reset_color}'"
  fi
}

# Real-time RAM usage tracking
function rams() {
  local app="$1"
  local sum

  if [ -z "$app" ]; then
    echo "Usage: rams <pattern>"
    return 1
  fi

  while true; do
    sum=$(_calcram "$app")
    if [[ "$sum" != "0" ]]; then
      echo -en "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MB of RAM\r"
    else
      echo -en "No active processes matching pattern '${fg[blue]}${app}${reset_color}'\r"
    fi
    sleep 1
  done
}

# <- -----------------------------------X----------------------------------- ->

# Reads input from either stdin (if piped) or arguments. (Helper Function)
function get_stdin_and_args() {
    if [ -p /dev/stdin ] && [ -z "$*" ]; then
        cat -
    else
        echo "$*"
    fi
}

# Removes leading whitespace from the input.
function ltrim() {
    local input
    input=$(get_stdin_and_args "$@")
    echo "${input##+([[:space:]])}"
}

# Removes trailing whitespace from the input.
function rtrim() {
    local input
    input=$(get_stdin_and_args "$@")
    echo "${input%%+([[:space:]])}"
}

# Removes both leading and trailing whitespace from the input.
function trim() {
    local input
    input=$(get_stdin_and_args "$@")
    input="${input##+([[:space:]])}"
    echo "${input%%+([[:space:]])}"
}

# Removes all whitespace (spaces, tabs, newlines) from the input.
function trim_all_whitespace() {
    local input
    input=$(get_stdin_and_args "$@")
    echo "$input" | tr -d '[:space:]'
}
