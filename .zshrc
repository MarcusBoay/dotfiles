# Enable Powerlevel10k instant prompt. Should stay close to the top of /tmp/jenny-code-zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jenny/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# setopt IGNORE_EOF             # Ctrl+D won’t exit the shell

# # Use vi key bindings
# bindkey -v

# # Make Ctrl+Left/Right move by word
# bindkey "^[[1;5D" backward-word
# bindkey "^[[1;5C" forward-word
# bindkey "^[[5D" backward-word
# bindkey "^[[5C" forward-word

# # Start typing + [Up-Arrow] - fuzzy find history forward
# autoload -U up-line-or-beginning-search
# zle -N up-line-or-beginning-search

# bindkey -M emacs "^[[A" up-line-or-beginning-search
# bindkey -M viins "^[[A" up-line-or-beginning-search
# bindkey -M vicmd "^[[A" up-line-or-beginning-search
# if [[ -n "${terminfo[kcuu1]}" ]]; then
#   bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
#   bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
#   bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
# fi

# # Start typing + [Down-Arrow] - fuzzy find history backward
# autoload -U down-line-or-beginning-search
# zle -N down-line-or-beginning-search

# bindkey -M emacs "^[[B" down-line-or-beginning-search
# bindkey -M viins "^[[B" down-line-or-beginning-search
# bindkey -M vicmd "^[[B" down-line-or-beginning-search
# if [[ -n "${terminfo[kcud1]}" ]]; then
#   bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
#   bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
#   bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
# fi

# # Aliases
# alias c="clear"
# alias switch="sudo nixos-rebuild switch"
# alias l="eza -lah"
# alias ll="eza -l"
# # git aliases
# alias ga="git add"
# alias gaa="git add --all"
# alias gb="git branch"
# alias gco="git checkout"
# alias gcb="git checkout -b"
# alias gcmsg="git commit --message"
# alias gd="git diff"
# alias glo="git log --oneline --decorate"
# alias glg="git log --stat"
# alias gl="git pull"
# alias gp="git push"
# gpsup() {
#   git push --set-upstream origin $(git_current_branch)
# }

# export PATH="${PATH}:${HOME}/.cargo/bin";


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
