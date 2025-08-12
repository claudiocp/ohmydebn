# OhMyDebn

OhMyDebn is a debonair Debian + Cinnamon setup inspired by Omarchy.

![OhMyDebn screenshot](images/ohmydebn.png)

# Debonair Haiku

*Debonair strides bold,*  
*Elegance in every step,*  
*Stars bow to its charm.*  
  -- AI, probably

# Motivation
Every year or so, I review my technology stack to make sure I'm using the best tools for the job. Starting from first principles, I consider needs, desires, and workflows and ask myself a few questions: 
- What is the best operating system for those needs, desires, and workflows? Is it Windows, macOS, Linux, or a combination thereof? Since discovering Linux in 1997, it has been my primary desktop environment for most of those years and it continues to be the environment where I'm most productive. 
- What about apps? What are the best of breed productivity apps that help me get my job done with a minimum amount of fuss? 
- What is the Linux desktop environment that allows me to work with all of those applications at the same time most efficiently?
- Finally, which Linux distro provides that desktop environment and those apps and runs on the hardware that I need it to?

# Inspiration
Inspired by [DHH](https://dhh.dk/) and his [Omakub](https://omakub.org/) and [Omarchy](https://omarchy.org/) setups, this is my own personal [omakase](https://en.wikipedia.org/wiki/Omakase) menu for my ideal desktop environment. It is a curated collection of comprehensive components that balances the ideals of productivity, flexibility, and beauty.

# Ingredients
- Base OS: [Debian](https://www.debian.org/) 13 for stability and compatibility
- Desktop environment: [Cinnamon](https://github.com/linuxmint/Cinnamon) for a premium desktop experience
- Window themes: artfully polished themes from [Linux Mint](https://linuxmint.com/)
- Wallpaper: beautiful [Catppuccin mountain landscape](https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/salty_mountains.png)
- Terminal emulator: [alacritty](https://alacritty.org/) with Caskaydia Nerd Fonts and [Catppuccin Mocha theme](https://github.com/catppuccin/alacritty)
- Text editor: [neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/) and [Catppuccin theme](https://github.com/catppuccin/nvim)
- Performance monitoring: [btop](https://github.com/aristocratos/btop) with [Catppuccin Mocha theme](https://github.com/catppuccin/btop)
- System summary: [screenfetch](https://github.com/KittyKatt/screenFetch)
- Web browser: [Chromium](https://www.chromium.org/Home/) with uBlock Origin Lite content blocker
- Password management: [KeePassXC](https://keepassxc.org/)
- Window automation: [xdotool](https://github.com/jordansissel/xdotool)
- Eye candy: dazzling terminal effects via [tte](https://github.com/ChrisBuilds/terminaltexteffects) for demo scene nostalgia

# Why Debian?
I want to use the same base OS in a few different environments:
- bare metal and virtualized
- virtualized via Proxmox, Parallels, and other hypervisors
- when running under Parallels, I need a distro that is supported by Parallels Tools
- x86 and eventually ARM (this script has not yet been tested on ARM but it should be easy to make it work)

# Why Debian Cinnamon?
Why use Debian Cinnamon instead of Linux Mint or Linux Mint Debian Edition (LMDE)? Linux Mint and LMDE are great, but there are a few reasons why you might want to use Debian 13 Cinnamon instead:
- Linux Mint is only available for x86 architecture. If you're on ARM, you need a distro compiled for ARM that can run Cinnamon (like Debian). Please note that this script has not yet been tested on ARM but it should be easy to make it work.
- Suppose you want to take a Debian 13 derivative (like Proxmox 9) and add the Cinnamon desktop. You can then use this script to turn it into OhMyDebn!
- For fun and for science!
  
# Examples

Here's my OhMyDebn battle station! It's a MacBook Pro running MacOS and Parallels with 3 VMs: one VM is my daily driver where I do most of my work and the other two are test VMs.

![OhMyDebn Battle Station](images/ohmydebn-battle-station.png)

# Requirements
OhMyDebn requires the following:
- 2GB RAM minimum
- 2 CPU cores minimum
- Debian 13 with Cinnamon desktop
- user account with sudo privileges
- ability to connect to Github, package repos, and other Internet sites
  
# Warnings
This script:
- is intended for a clean new installation
- will remove apps like FireFox, Thunderbird, and others
- may make changes to your APT configuration

This script is totally unsupported. If it breaks your system, you get to keep both pieces!

# Installation
1. Download the Debian Live 13 Cinnamon ISO image from https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/ and install it. Reboot into your newly installed Debian 13 Cinnamon and the default desktop should look like this:
![debian-cinnamon screenshot](images/debian-cinnamon.png)
2. In your Debian 13 Cinnamon desktop, download and review the script (don't just blindly pipe it into bash):
```
curl -O https://raw.githubusercontent.com/dougburks/ohmydebn/refs/heads/main/install.sh
```
3. Run the script:
```
bash install.sh
```
4. Enjoy your new OhMyDebn desktop!

![OhMyDebn screenshot](images/ohmydebn.png)

# Hotkeys

## Navigating

| Hotkey | Function |
|--------|----------|
| Alt+Tab | Cycle through open windows |
| Shift+Alt+Tab | Cycle backwards through open windows |
| Alt+F2 | Run dialog |
| Alt+Space | Activate window menu |
| Alt+F7 | Move window |
| Super+D | Show desktop |
| Super+Left | Push window left |
| Super+Right | Push window right |
| Super+Up | Push window up |
| Super+Down | Push window down |
| Super+PageUp | Maximize window |
| Super+PageDown | Minimize window |
| Ctrl+Alt+Up | Workspace selection |
| Ctrl+Alt+Down | Window selection |
| Ctrl+Alt+Left | Switch to left workspace |
| Ctrl+Alt+Right | Switch to right workspace |
| Shift+Ctrl+Alt+Left | Move window to left workspace |
| Shift+Ctrl+Alt+Right | Move window to right workspace |
| Ctrl+Alt+L | Lock screen |
| Ctrl+Alt+Del | Logout |
| Ctrl+Alt+End | Shut down |
| Ctrl+Alt+Escape | Restart Cinnamon desktop |

## Apps

| Hotkey | Function |
|--------|----------|
| Super+B | Browser (Chromium) |
| Super+Return | Terminal |
| Super+F | File Manager |

## Password and Bookmark Management (KeePassXC)

| Hotkey | Function |
|--------|----------|
| Ctrl+Shift+K | Open or activate KeePassXC |
| Ctrl+Shift+U | Open browser tab to selected URL |
| Ctrl+Shift+P | Auto-type username and password for selected site |
| Ctrl+N | Create a new entry in KeePassXC |
| Ctrl+E | Edit entry |
| Ctrl+B | Copy username |
| Ctrl+C | Copy password |
| Ctrl+U | Copy URL |

## Configuration

| Hotkey | Function |
|--------|----------|
| Shift+Super+N | Network Manager |
| Shift+Super+S | Sound menu |

## Capture

| Hotkey | Function |
|--------|----------|
| Shift+Print | Take a screenshot of an area |
| Shift+Ctrl+Print | Copy a screenshot of an area to clipboard |
| Print | Take a screenshot |
| Ctrl+Print | Copy a screenshot to clipboard |
| Alt+Print | Take a screenshot of a window |
| Ctrl+Alt+Print | Copy a screenshot of a window to clipboard |

## Notifications

| Hotkey | Function |
|--------|----------|
| Super+N | Show notifications |
| Shift+Super+C | Clear notifications |

## Neovim (with LazyVim)

### Navigation

| Hotkey | Function |
|--------|----------|
| Space | Show command options |
| Space Space | Open file via fuzzy search |
| Space E |	Toggle sidebar |
| Space G G | Show git controls |
| Space S G | Search file content |
| Ctrl + W W | Jump between sidebar and editor |
| Ctrl + Left/right arrow | Change size of sidebar |
| Shift + H | Go to left file tab |
| Shift + L | Go to right file tab |
| Space B D | Close file tab |

### While in sidebar

| Hotkey | Function |
|--------|----------|
| A | Add new file in parent dir |
| Shift + A | Add new subdir in parent dir |
| D | Delete highlighted file/dir |
| M | Move highlighted file/dir |
| R | Rename highlighted file/dir |
| ? | Show help for all commands |

For the full list of all Neovim hotkeys configured by LazyVim, please see https://www.lazyvim.org/keymaps.

# FAQ

## Is this related to Security Onion?

OhMyDebn is not directly related to the [Security Onion](https://github.com/Security-Onion-Solutions/securityonion) project. OhMyDebn is sponsored by [Security Onion Solutions](https://securityonion.com); however, [Security Onion Solutions](https://securityonion.com) does not provide any technical support for it. OhMyDebn is intended to provide a general purpose desktop environment so, of course, you could use the included Chromium web browser to connect to your [Security Onion Console](https://docs.securityonion.net/en/2.4/soc.html)!
