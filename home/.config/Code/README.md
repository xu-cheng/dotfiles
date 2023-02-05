# Visual Studio Code settings

## Enable key-repeating

```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## Dump plugins
```
code --list-extensions > ~/.config/Code/plugins
```

## Install plugins
```
cat ~/.config/Code/plugins | xargs -L1 code --install-extension
```
