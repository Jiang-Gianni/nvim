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

