# Visual Studio Code settings

## Dump plugins
```
code --list-extensions > ~/.config/vscode/plugins
```

## Install plugins
```
cat ~/.config/vscode/plugins | xargs -L1 code --install-extension
```
