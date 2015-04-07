Quick Look Settings
===================

## Install Plugins

```bash
brew cask install betterzipql
brew cask install qlcolorcode
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlrest
brew cask install qlstephen
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install suspicious-package
brew cask install webpquicklook
qlmanage -r
```

## Enable Text Select

```bash
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder
```
