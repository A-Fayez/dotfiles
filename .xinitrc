#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#hdmi_active=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')
#[[ ! -z "$hdmi_active" ]] && exec ~/.screenlayout/arandr.sh

DISPLAY=":0" nm-applet &
DISPLAY=":0" blueman-applet &
setxkbmap -model pc105 -layout us,ara -option grp:alt_shift_toggle
DISPLAY=":0" picom -b &
exec i3

