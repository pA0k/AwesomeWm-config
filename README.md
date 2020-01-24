<p align="center">Awesome wm military style</p>

<p align="center">
  <a href="https://lbesson.mit-license.org/"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>

 <a href="https://github.com/paranoid73/AwesomeWm-config/graphs/commit-activity"><img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" alt="commit"></a>

 <a href="https://github.com/paranoid73/"><img src="https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg" alt="askme"></a>
  <br>

</p>

## Introduction  
[Awesome Wm](https://awesomewm.org/) configuration  , inspired [Everfree-TEC-design](https://www.behance.net/gallery/79573713/Everfree-TEC-design) . This configuration is compatible with awesome WM 4. 


## Requirements
  
| Dependency | Description                                                                                                         |
|------------|---------------------------------------------------------------------------------------------------------------------|
| awesome    | framework window manager for X.                                                            |
| redshift   | Redshift adjusts the color temperature of your screen according to your location.          |
| urxvt       | terminal                                    |
| maim       | maim (make image) takes screenshots of your desktop.                                       |
| compton    | Compton is a standalone compositor for Xorg, suitable for use with window managers that do not provide compositing. |
| fonts    | Industry Black , Samsung Sans , Time Won , Roboto |
| light-locker    | to lock screen |
|nm-applet     | if you use network-manager  |
|notify-send     | for notifications  |

## Installation

     git clone https://github.com/paranoid73/AwesomeWm-config.git ~/.config/awesome --recursive

## Note:
     In order to prevent power key from shutting down the system, 
     edited the file /etc/systemd/logind.conf
     uncommented #HandlePowerKey=poweroff line and changed it to
     HandlePowerKey=ignore

## Screenshots

![full_screen](resources/screenshots/2019.09.29-07.58.41.screenshot.png)  

#### Keyboard

+ `ctrl + MOD4 + r` - Reload config
+ `shift + MOD4 + q` - Exit 
+ `MOD4 + F1` - show help
+ `MOD4 + enter` - open a terminal
+ `MOD4 + c`     - Close client
+ `MOD4 + control + space` - Toggle floating client
+ `MOD4 + [1-0]` - View tag 
+ `MOD4 + Shift + [1-0]` - Move focused client to tag
+ `MOD4 + f` - Toggle fullscreen
+ `MOD4 + m` - (un)maximize horizontally
+ `MOD4 + Shift +m` - (un)maximize vertically
+ `MOD4 + n` - Minimize
+ `MOD4 + shift + n` - Restore minimized
+ `MOD4 + u` - Jump to urgent client 
+ `MOD4 + p` - Show menubar 
+ `MOD4 + t` - toggle keep on top
+ `MOD4 + s` - toggle sticky client
+ `Print` - take screenshot
+ `MOD4 + Print` - to select area and screenshot
+ `ALT_LEFT + Tab` - client switcher

## wishlist
- [x]  exit screen

- [ ] customize notification

- [ ] tasklist's icon list  


## Want to help?
contribute some code, or improve documentation ? always open .
This config could be even better with your help.


