# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=400
SAVEHIST=1000
bindkey -v
#bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gunnar/.zshrc'

setopt HIST_IGNORE_DUPS


autoload -U colors && colors
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# End of lines added by compinstall
#

PROMPT="%{$fg_no_bold[green]%}%m %{$fg_bold[yellow]%}%1~%{$fg_bold[white]%} $ %{$reset_color%}"
setopt promptsubst

export BROWSER=firefox
export EDITOR=tkak
export PATH="${PATH}:${HOME}/.cargo/bin:${HOME}/.local/bin"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

export AWT_TOOLKIT=MToolkit

#export CARGO_HOME=".cargo"

autoload -U run-help
autoload run-help-git
autoload run-help-sudo
#autoload run-help-svn
#autoload run-help-svk

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#unalias if already aliased
case $(type run-help) in
    (*alias*) unalias run-help;;
esac
alias help=run-help

#export RUST_SRC_PATH=/usr/local/src/rust/src

alias keychain-start='eval $(keychain --eval --agents ssh -Q --quiet id_rsa)'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sys-update='pikaur -Syyu'
alias pacman-autoremove='sudo sh -c "pacman -Qdtq | pacman -Rs -"'
alias ghcid-stack='ghcid --command="stack repl"'
alias tping='ping 8.8.8.8'
alias ghci-core="ghci -ddump-simpl -dsuppress-idinfo \
    -dsuppress-coercions -dsuppress-type-applications \
    -dsuppress-uniques -dsuppress-module-prefixes"
alias ls='exa'
alias cclip="xclip -sel cur"
alias sbr='rlwrap sbcl'
alias tkak='tmux new kak'

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export UNI="627030@ssh-gate.uni-luebeck.de"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key


key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


stty -ixon

if [ -z "$SSH_AUTH_SOCK" ] ; then
    {
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa.github
        ssh-add ~/.ssh/id_rsa.uni
        ssh-add ~/.ssh/id_rsa.isp
    } > /dev/null &> /dev/null

    trap 'kill $SSH_AGENT_PID' EXIT
fi

# Disable ^S and ^Q.
unsetopt flowcontrol

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

