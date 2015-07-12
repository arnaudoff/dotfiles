# My own vim cheatsheet

Disclaimer: This is pretty much for my own use. It will be updated (as I get to grips with vim) in the next days, weeks, months, years, decades..or centuries.

`:` - Enter command mode  
`:e` - Open a new file  
`:e $MYVIMRC` - Open the configuration file  
`:so $MYVIMRC` - Source the configuration file (reload)  
`Esc`, `^C` - Enter normal mode  

#### Normal mode
`h` - Move left  
`j` - Move down  
`k` - Move up  
`l` - Move right  

`5j` - Move down 5 lines  
`3l`- Move left 3 characters  
`gg` - Move on top of the file  
`5gg` - Move to line 5  
`7G` - Move to line 7  

`w` - Jump one word forward (start of next word)  
`e` - Jump one word forward (end of next word)  
`b` - Jump one word backwards  
`$` - Jump to end of line  
`0` - Jump to start of line (including whitespace)  
`^` - Jump to start of line (first non-whitespace character)  

##### Motions
`d` - Delete something  
`c` - Change something  
`y` - Yank something  
`p` - Paste something  

`x` - Delete a character  
`r` - Replace a character  

`dw` - Delete word  
`dd` - Delete the whole line  
`cw` - Change word  
`yw` - Yank word  
`yy` - Yank the whole line  
`o` - Start new line  

#### Visual mode

`v` - Enter visual mode  
