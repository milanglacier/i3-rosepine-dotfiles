#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# a known issue with zsh-syntax-highlighting and termux,
# see https://github.com/termux/termux-packages/issues/1894
function fix_zsh_syntax_highlighting_on_termux() {
    uname -a | grep Android > /dev/null && \
        [ -f "$HOME/.zim/modules/completion/init.zsh" ] && \
        sed -E -i 's/^(\s+)(setopt NO_CASE_GLOB)/\1# \2/' "$HOME/.zim/modules/completion/init.zsh"
}

# Begin zimfw {{{
# Sensible configuration setup by zimfw - relocate these settings to the user
# configuration

# remove duplicated entries in zsh history
setopt HIST_IGNORE_ALL_DUPS
# Set emacs style keybinding
bindkey -e
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

[ -f "$HOME/.zimfw-setup.sh" ] && source ~/.zimfw-setup.sh

# End zimfw }}}

[[ -x "$(which fzf)" ]] && source <(fzf --zsh)
[ -x "$(which zoxide)" ] && eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"

# If current shell is running inside neovim, then set nvr as the
# default editor
if [[ $NVIM && -x "$(which nvr)" ]]; then
    # open a new tab in current neovim process to open the file and
    # the nvr process is blocking. Only quit the nvr process if the
    # opened buffer is killed by current neovim process.
    export EDITOR='nvr -cc tabnew --remote-wait'
fi

[ -x "$(which nvim)" ] && export EDITOR=nvim

if [ "$TERM" = "dumb" ]; then
┆   unsetopt zle && PS1='$ '
fi
