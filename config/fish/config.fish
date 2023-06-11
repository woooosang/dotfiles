# ls aliases
alias l='exa --icons --no-user --color=always --group-directories-first'
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --icons --all --git --group-directories-first'  # long format
alias lt='exa -aT --color=always --icons --group-directories-first' # tree listing

# lazygit
alias lg=lazygit

# neovim
alias vi='$HOME/Applications/nvim.appimage'
alias emacs='emacsclient -t'

# batcat
alias b='bat'
alias bathelp='bat --plain --language=help'
function help
    $argv --help 2>&1 | bathelp
end

# exports
set fish_greeting
set -gx EDITOR vi
set -gx VISUAL vi
set XDG_CONFIG_HOME $HOME/.config
set JAVA_HOME "/usr/bin/jdk-17.0.7+7"

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

function fish_user_key_bindings
  fish_default_key_bindings
  # fish_vi_key_bindings
end

# Functions needed for !! and !$
# Source: gitlab.com/dwt1/dotfiles/-/blob/master/.config/fish/config.fish
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

zoxide init fish | source
starship init fish | source
