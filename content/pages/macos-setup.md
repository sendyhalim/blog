+++
title = "Setting a new Mac"
date = 2025-03-05T00:00:00+07:00
transparent = false

description = "Hi, I'm Sendy Halim, I'm passionate about solving problems with tech."

[taxonomies]
tags = ["macos"]
+++

A document to setup a new Mac.

### Development Environment
#### Applications
```
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install applications
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask scroll-reverser  # Reverse scroll on mouse (more natural)
brew install --cask hammerspoon      # Tiling window manager
brew install --cask dropbox
brew install neovim

# Install pynvim
pip3 install 'pynvim @ git+https://github.com/neovim/pynvim' --break-system-packages

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable
```

#### Git
##### Generate SSH
```
# Generate new ssh key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add ssh key to ssh agent
eval "$(ssh-agent -s)"
```

##### Input git password once per session
* Open `~/.ssh/config`
* Set:
```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

##### Dotfiles
```
git clone https://github.com/sendyhalim/dotfiles
cd dotfiles && ./install.sh
```


### MacOS System Settings
#### Three Finger Drag
* Navigate: Settings > Accessibility > Pointer Control > Trackpad Options
* Set: Enable `Use trackpad for dragging`
* Set: Dragging style `Three Finger Drag`


#### Control Quick Access
* Navigate: Settings > Desktop & Dock > Hot Corners
* Set: Set bottom right `Mission Control`

#### Screenshot
Put screenshot into clipboard by default:
* Navigate: System Settings > Keyboard shortcuts > Screenshots
* Set: Copy picture of screen to the clipboard: `Shift + CMD + 3`
* Set: Copy picture of selected are to the clipboard: `Shift + CMD + 4`

