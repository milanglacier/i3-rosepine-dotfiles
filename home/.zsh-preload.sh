#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -x "$(which brew)" ] && FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# a known issue with zsh-syntax-highlighting and termux,
# see https://github.com/termux/termux-packages/issues/1894
function fix_zsh_syntax_highlighting_on_termux() {
    uname -a | grep Android > /dev/null && \
        [ -f "$HOME/.zim/modules/completion/init.zsh" ] && \
        sed -E -i 's/^(\s+)(setopt NO_CASE_GLOB)/\1# \2/' "$HOME/.zim/modules/completion/init.zsh"
}
export MY_DOTFILES_DIR="$HOME/Desktop/dotfiles"


# Sensible configuration setup by zimfw.
# relocate these settings to the user configuration
# Begin zimfw {{{

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

