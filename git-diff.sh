git diff main --name-only | fzf --preview 'git diff main -- {}' | xargs git difftool main
