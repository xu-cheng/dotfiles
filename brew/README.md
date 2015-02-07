Homebrew
========

## Create Brewfile

* `brew brewdle dump`
* `brew ls -1 > .brew-cleanup-installed`
* `ln -s $(pwd)/.brew-cleanup-installed $HOME`

## Restore Brews

* `brew tap homebrew/brewdler`
* `brew brewdle`
