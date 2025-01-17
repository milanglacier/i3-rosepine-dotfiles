#!/bin/zsh


# Sensible configuration setup by zimfw.
# relocate these settings to the user configuration
# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# macOS builtin ncurses doesn't have tmux-256color terminfo
# manually compile tmux-256color terminfo and put it under $HOME/.local/share/terminfo directory
[ -d "$HOME/.local/share/terminfo" ] && export TERMINFO_DIRS=$HOME/.local/share/terminfo${TERMINFO_DIRS+:$TERMINFO_DIRS}

command -v fzf >/dev/null && source <(fzf --zsh)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ "$TERM_PROGRAM" = "iTerm.app" ]]
then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Created by `pipx` on 2022-07-31 19:12:20
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"

# bashcompinit must be called after compinit
command -v pipx >/dev/null && \
    [ "$TERM" != "dumb" ] && \
    command -v register-python-argcomplete >/dev/null && \
    eval "$(register-python-argcomplete pipx)"

command -v nvim >/dev/null && export EDITOR=nvim

# If current shell is running inside neovim, then set nvr as the
# default editor
if [[ $NVIM ]] && command -v nvr >/dev/null; then
    # open a new tab in current neovim process to open the file and
    # the nvr process is blocking. Only quit the nvr process if the
    # opened buffer is killed by current neovim process.
    export EDITOR='nvr -cc tabnew --remote-wait'
fi

if [ "$TERM" = "dumb" ]; then
┆   unsetopt zle && PS1='$ '
fi

[ -d "$MY_DOTFILES_DIR" ] && export PATH="$PATH:$MY_DOTFILES_DIR/bin"
