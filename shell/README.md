Shell Settings
==============

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

plugins=(git git-flow git-hubflow ssh-agent mercurial svn pip pyenv autojump dirhistory colored-man brew brew-cask osx)

export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:${PATH}
export EDITOR="nvim"
export PYENV_ROOT="$HOME/.pyenv"
export CHEATCOLORS=true

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
[[ -s /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

compinit

alias rake='noglob rake'
alias vim='nvim'
alias subl='subl && sleep 0.1 && subl'

clean_hist(){
    rm -f "$HOME/.zsh_history"
}
```
