# How to set up my dotfiles?
Easy just git clone the repo anywhere on your system go into that directory
```sh
git clone https://github.com/HarshK200/dotfiles.git
cd dotfiles
```
## DO NOT REMOVE THIS GIT CLONED DIRECTORY!!!
since we'll be using symlinks to point to it and a simple git pull can easliy get you up to date with my dotfiles

Make sure stow is installed on your system
```sh
sudo apt-get install stow
```

then just run the following command from within the repo directory:
```sh
export DOT=$(pwd)
```


## Now making the symlinks (if you have no idea what those are just copy the below commands and run them)
```sh
stow -v -R -t ~ nvim
stow -v -R -t ~ tmux
stow -v -R -t ~ kitty
stow -v -R -t ~ i3
stow -v -R -t ~ rofi
stow -v -R -t ~ scripts
stow -v -R -t ~ zsh
```
You can pick and choose which dotfiles you want from the above symlinks and just run the specific command
have fun!
