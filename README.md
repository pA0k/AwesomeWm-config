
## Introduction  
my personal setup for [Awesome Wm](https://awesomewm.org/) , still needs improvement for it to be as advanced as possible and inspired by [worron config](https://github.com/worron/awesome-config).

## Requirements

**Browser**: Google Chrome , FireFox

  

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

## wishlist

- [x]  exit screen

- [ ] customize notification

- [ ] titlebar

- [ ] customize tasklist  

## License
My awesome wm config is open-source , licensed under the [MIT license](https://opensource.org/licenses/MIT).

