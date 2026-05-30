```bash
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!.git"'
  export FZF_DEFAULT_OPTS='-m'
fi

cd ~/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

sudo apt install ripgrep fzf fd-find vim-gtk libc6-dev

# 25.10
https://github.com/tree-sitter/tree-sitter/releases?q=v0.25.10&expanded=true

cp -r snippets ~/.vim/

cp .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

$(brew --prefix)/opt/fzf/install

git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"'
```

### Maybe useful stuff

- Search and replace for elements in quickfix list and in buffers
```bash
:grep "pizza"
:cfdo %s/pizza/donut/g | update

:Files (+Tab selection and opening)
:bufdo %s/pizza/donut/g | update
```

- Delete all buffers and opens the last file:
```bash
:%bd | e#
```

- [Custom text objects](https://github.com/kana/vim-textobj-user)

### Leader Keyboard
q close buffer
w save buffer
f fzf
p
l lsp
u undo tree toggle
y
g git
a substitute and snippet
r ctrl-r (re-play after undo)
s leap.nvim search 
t harpoon
n window navigation
e trouble quickfix toggle
i ctrl-i (jump to next)
o ctrl-o (jump to old)
z ctrl-z (suspend)
x execute current paragraph
c
v
m
d delete without filling the register
h copy file path to clipboard
b to netrw
j
k
