# gi_extension
This is a ***non-offical*** extension for the command `gi` in [gitignore.io](https://www.gitignore.io)  
The function of `gi` provide a quick access to various .gitignore on gitignore.io 

This extension supports more functions than the original `gi`.

# Installation
## Install
```
sudo cp gi_extension.sh /usr/bin/gi
```
You would also need to comment out the `gi` function in your shell config(e.g. ~/.zshrc, ~/.bashrc) if you had set up that.

## Uninstall
```
sudo cp gi_extension.sh /usr/bin/gi
```

# USAGE
Read [document for gi](https://github.com/joeblau/gitignore.io) first for better knowing how this extension works.  
Note that you don't need to export the gi wrote in the document.  

This program create a `~/.gi_list` file for quick access to the all supported types which is obtained from the original `gi list`.  
You would need to run `gi -u` in your first use.  
After that, every time this program is executed, it will update the list in background for next time use.  


```shell 
gi  <types>
    [-a| -e] <types>
    [-u| -t| -l| -L]
```
If multiple types are needed, you can seperate them with comma or space.  
e.g. `osx,vim` `osx vim`

-a [types] - apeend new .gitignore content to .gitignore under the current directory  
-e [types] - export new .gitignore to the current directory (The old one will be replaced.)  
-L -  print `~/.gi_list` in alphabetical order  
-l -  print `~/.gi_list` in table format  
-u - update `~/.gi_list`  
-t - show the last modified time of `~/.gi_list`  

# AUTHORS
[Lee-W](https://github.com/Lee-W/)

# LICENSE
MIT
