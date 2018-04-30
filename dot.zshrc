# Ubuntu suggested conf

autoload -Uz promptinit
promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Until here Ubuntu's suggested configs ###

# Let's you do 5*7 without quoting, otherwise if the file glob doesn't expand to a file throws an error
unsetopt nomatch

# Remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE

# PROMPT='[%n@%m %~]$ '

# Make time look like bash instead of the zsh version
disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output
# or  TIMEFMT=$'\nreal\t%*Es\nuser\t%*Us\nsys\t%*Ss'

# autojump
. /usr/share/autojump/autojump.zsh

#fix annoying zsh word jump behaviour
bindkey '^[^[[C' forward-word # alt right arrow to jump word
bindkey '^[^[[D' backward-word # alt left arrow to jump backwards word
autoload -U select-word-style
select-word-style bash

# Use vim
export VISUAL=vim
export EDITOR="$VISUAL"

# alias
alias ll='ls --color -lh'
alias la='ll -art'
alias d="docker-compose"

# Show current branch in current submodule
setopt prompt_subst
source $(brew --prefix)/etc/bash_completion.d/git-prompt
export RPROMPT=$'$(__git_ps1 "%s")'

# Export

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Alias

alias j autojump
