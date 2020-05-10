# Visual Studio Code settings

## Dump plugins
```
code --list-extensions > ~/.config/Code/plugins
```

## Install plugins
```
cat ~/.config/Code/plugins | xargs -L1 code --install-extension
```
