xrdb -merge .Xresources
unclutter -idle 1 &
wallpaper wallpaper.jpg
setterm -blank 0
xset s off
xmodmap .xmodmap
exec xmonad
xrandr --output VGA-1 --auto 
