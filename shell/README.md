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
brew install coreutils findutils binutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt
brew install wget readline tree htop cheat pandoc
brew install git git-flow hg svn autojump vim macvim zsh-syntax-highlighting
brew install graphicsmagick ghostscript graphviz
brew tap phinze/cask; brew install brew-cask
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

* Copy `mytheme.zsh-theme` to `~/.oh-my-zsh/custom`
* Add below code into `~/.zshrc`:

```bash
ZSH_THEME="mytheme"

plugins=(git git-flow git-hubflow mercurial svn pip pyenv autojump dirhistory colored-man brew brew-cask osx)

export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:${PATH}
export EDITOR="subl -w"
export PYENV_ROOT="$HOME/.pyenv"
export CHEATCOLORS=true

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
[[ -s /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

compinit

clean_hist(){
    rm -f "$HOME/.zsh_history"
}
```
