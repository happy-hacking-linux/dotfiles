xrdb -merge .Xresources
unclutter -idle 1 &
setterm -blank 0
xset s off
xmodmap .xmodmap
xset -r 135 
xrandr --output VGA-1 --auto 
feh --bg-fill ~/wallpaper.jpg &
exec xmonad
