xrdb -merge .Xresources
unclutter -idle 1 &
setterm -blank 0
xset s off
xmodmap .xmodmap
xset -r 135 
feh --bg-fill /home/azer/wallpaper.jpg
xrandr --output VGA-1 --auto 
exec xmonad
