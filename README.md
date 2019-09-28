
## Introduction  
my personal setup for [Awesome Wm](https://awesomewm.org/) , inspired from the [Red Flat Awesome WM config](https://github.com/worron/awesome-config) . This configuration is compatible with awesome WM 4.


## Requirements
  
**Terminal**: [urxvt](https://wiki.archlinux.fr/urxvt)

**File manager**: thunar , ranger  

**Compositor**: compton

**Font**: Industry Black , Samsung Sans , Time Won , Roboto
  
**Others**: notify-send , maim , nm-applet  , light-locker , redshift

## Installation

     git clone https://github.com/paranoid73/AwesomeWm-config.git ~/.config/awesome --recursive

## Note:
     In order to prevent power key from shutting down the system, 
     edited the file /etc/systemd/logind.conf
     uncommented #HandlePowerKey=poweroff line and changed it to
     HandlePowerKey=ignore

## Screenshots

![full_screen](resources/screenshots/2019.09.24-09.10.58.screenshot.png)  

#### Keyboard
+ `ctrl + MOD4 + r` - Reload config
+ `shift + MOD4 + q` - EXIT
+ `MOD4 + F1` - show help
+ `MOD4 + enter` - open a terminal
+ `MOD4 + enter` - open a terminal
+ `MOD4 + c`     - Close client
+ `MOD4 + control + space` - Toggle floating client
+ `MOD4 + [1-0]` - View tag 
+ `MOD4 + shift + [1-0]` - Move focused client to tag
+ `MOD4 + f` - Toggle fullscreen
+ `MOD4 + m` - Toggle maximize
+ `MOD4 + n` - Minimize
+ `MOD4 + shift + n` - Restore minimized
+ `MOD4 + u` - Jump to urgent client 
+ `MOD4 + p` - Show menubar 

## wishlist

- [x]  exit screen

- [ ] customize notification

- [ ] customize titlebar

- [ ] customize tasklist  

- [ ] change layout of help

## License
licensed under the [MIT license](https://opensource.org/licenses/MIT.

