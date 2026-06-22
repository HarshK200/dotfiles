# ======================= my custom alias =======================

alias godot='Godot_v4.6.3-stable_win64.exe'
alias l='ls -la'
alias v='nvim'


# ======================= my custom scripts =======================

# Bind Ctrl+T to source folder picker script
bind '"\C-t": "source /c/Users/Harsh/.dotfiles/scripts/.scripts/win_fzf_folder.sh\n"'


# ======================= my custom scripts =======================

# custom prompt look
PS1='\[\033[32m\]➜ \[\033[33m\]\W\[\033[36m\]$(__git_ps1 " \[\033[35m\]git: \[\033[36m\](%s)")\[\033[0m\] '
