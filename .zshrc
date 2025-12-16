# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Zsh Syntax Highlighting Customization ---
# First, declare the variable as an associative array.
typeset -A ZSH_HIGHLIGHT_STYLES

# Now, we can add our custom styles.
# Make valid commands neon red (196) and bold.
ZSH_HIGHLIGHT_STYLES[command]='fg=196,bold'
# --- End of Customization ---

# --- Enhanced Autocompletion Settings ---
# These settings improve tab completion behavior.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' auto-selection 'always'
zstyle ':completion:*' menu select
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' group-name ''
# --- End of Autocompletion Settings ---

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#path
export PATH="$HOME/.local/bin:$PATH"

# --- Custom Keybindings ---
# Bind Ctrl+Backspace to delete the word before the cursor
bindkey '^H' backward-kill-word
# --- End of Custom Keybindings ---

# --- Custom Functions --- 

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
