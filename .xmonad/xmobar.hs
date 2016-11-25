Config { font = "xft:Monaco:style=regular:pixelsize=12:antialias=true,hinting=true"
       , bgColor = "#002b36"
       , fgColor = "#657b83"
       , position = Top
       , lowerOnStart = True
       , commands = [ 
                     Run Com "/home/azer/.xmonad/xmobar-battery-widget" ["-s","-r"] "bat" 10
                    , Run Com "/home/azer/.xmonad/now" ["-s","-r"] "now" 10
                    , Run Cpu ["-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
                    , Run Memory ["-t", "Mem: <usedratio>%"] 10
                    , Run Com "/home/azer/.xmonad/xmobar-connection-widget" ["-s","-r"] "conn" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ %cpu% | %memory% | %conn% | <fc=#777>%bat%</fc> | <fc=#777>%now%</fc> "
       }
