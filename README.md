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

sudo apt install ripgrep fzf fd-find vim-gtk

mkdir -p ~/.vim/colors
mkdir -p ~/.config/nvim/colors
cp night-owl.vim ~/.config/nvim/colors/night-owl.vim
cp night-owl.vim ~/.vim/colors

cp -r snippets ~/.vim/

cp .vimrc ~/.vimrc
mkdir -p ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```
