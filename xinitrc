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

xsetroot -cursor_name left_ptr
#xset -dpms;xset s noblank
#xprop -remove _NET_WORKAREA

# Here Xfce is kept as default
# session=${1:-lxde}
session={$1:-xmonad}
exec /home/gunnar/.local/bin/xmonad

case $session in
    lxde                ) exec startlxde;;
    openbox             ) exec openbox-session;;
    xmonad		) exec /home/gunnar/.local/bin/xmonad;;

