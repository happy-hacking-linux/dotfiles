Config { font = "xft:Monaco:style=regular:pixelsize=13:antialias=true,hinting=true"
       , bgColor = "#222"
       , fgColor = "#666"
       , position = Top
       , lowerOnStart = True
       , commands = [ 
                     Run Com ".xmonad/widgets/battery" ["-s","-r"] "battery" 10
                    , Run Com ".xmonad/widgets/alsa-volume" ["-s","-r"] "volume" 10
                    , Run Com ".xmonad/widgets/time" ["-s","-r"] "time" 10
                    , Run Cpu ["-t", "CPU: <total>%", "-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
                    , Run Memory ["-t", "Memory: <usedratio>%","-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
                    , Run Com ".xmonad/widgets/connection" ["-s","-r"] "connection" 10
					, Run DynNetwork [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: kB/s
                             , "--High"     , "5000"       -- units: kB/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ %cpu% | %memory% %connection% | <fc=#777>%battery%</fc> | %volume% | <fc=#777>%time%</fc> "
       }
