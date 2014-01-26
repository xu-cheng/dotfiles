Shell Settings
==============

## iTerm 2

* Install iTerm 2 from [here](http://www.iterm2.com/).
* Install Color Scheme from [here](https://github.com/mbadolato/iTerm2-Color-Schemes). Use scheme `Monokai Soda`.

## homebrew

* Install homebrew:

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
```

* Install essential formulas:

```bash
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt
brew tap homebrew/dupes; brew install grep
brew install wget
brew install git git-flow hg svn
brew install autojump
```

## zsh

* Set zsh as default shell:

```bash
chsh -s /bin/zsh
```

* Install oh-my-zsh:

```bash
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

* Copy `mytheme.zsh-theme` to `~/.oh-my-zsh/themes`
* Add below code into `~/.zshrc`:

```bash
ZSH_THEME="mytheme"

plugins=(git git-flow mercurial svn python pip virtualenv virtualenvwrapper sublime vim autojump)

export EDITOR='subl -w'

source /usr/bin/virtualenvwrapper.sh

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

autoload -U zutil
autoload -U compinit
autoload -U complist
compinit
```