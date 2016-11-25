xrdb -merge .Xresources
unclutter -idle 1 &
feh --bg-fill ~/wallpaper.jpg
setterm -blank 0
xset s off
xmodmap .xmodmap
xrandr --output VGA-1 --auto 
