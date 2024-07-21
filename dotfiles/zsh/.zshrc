# vi mode
bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# case insensitive globbing
setopt NO_CASE_GLOB

# automatically change dir when entering a path and hitting return
setopt AUTO_CD

# saving history (zsh does not save history by default)
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# share history between multiple sessions
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# update history file after each command instead of upon session exit
setopt INC_APPEND_HISTORY

# expire duplicates
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplicates
setopt HIST_IGNORE_DUPS
# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# remove blank lines
setopt HIST_REDUCE_BLANKS
# verify before running history substitution with !!
setopt HIST_VERIFY

setopt CORRECT
setopt CORRECT_ALL

PROMPT='%F{246}%1~%f %(?.%F{green}●%f.%F{red}● [%?]%f) %(!.#.)'

# git info in right prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt PROMPT_SUBST

RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{magenta}%b%f'
zstyle ':vcs_info:*' enable git

# aliases
alias grep="grep --color=auto"
alias ls="ls -G"
alias mux="tmuxinator"

# aliases:git
alias gs="git status"
alias ga="git add"
alias gr="git rm"
alias gc="git commit"
alias gd="git diff"
alias gp="git push"
alias gl="git log"
alias gf="git fetch"
alias glo="git log --oneline"
alias gca="git commit --amend"
alias gcm="git commit -m"

# env
export PATH=$HOME/Library/Java/JavaVirtualMachines:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rbenv
eval "$(rbenv init -)"

# pyenv
export PATH=$(pyenv root)/shims:$PATH
export PATH=${HOME}/.local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
