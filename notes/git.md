Git Settings
============

## Generate SSH Key

* Run Command below to generate the key:

```bash
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/github_rsa -C "your_email@youremail.com"
```
* Add below content to `~/.ssh/config`:

```
Host github
    User git
    HostName github.com
    IdentityFile ~/.ssh/github_rsa
```

* Add key to ssh-agent

```bash
$ ssh-add -K ~/.ssh/github_rsa
```

* Upload public key to Github.

```bash
$ pbcopy < ~/.ssh/github_rsa.pub
```

* Test key

```bash
$ ssh -T github
```

## Set Git Config

Run below commands:

```bash
curl -L -s https://www.gitignore.io/api/osx,linux,windows > $HOME/.gitignore
git config --global core.excludesfile "$HOME/.gitignore"
git config --global user.name "Your Name"
git config --global user.email "your_email@yourmail.com"
git config --global user.signingkey "your gpg key id"
git config --global core.autocrlf input
git config --global core.editor nvim
git config --global diff.tool nvimdiff
git config --global merge.tool nvimdiff
git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"'
git config --global difftool.prompt false
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.diff auto
git config --global color.grep auto
git config --global color.showbranch auto
git config --global color.ui auto
git config --global alias.d difftool
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.rpo "remote prune origin"
git config --global alias.current-branch "symbolic-ref --short HEAD"
git config --global alias.unstage "reset HEAD --"
git config --global alias.staged "diff --staged"
git config --global alias.sign "cherry-pick --signoff"
git config --global alias.sync-upstream "\!CUR_BRANCH=\$(git current-branch) && git checkout master && git pull upstream master && git push origin master && git checkout \$CUR_BRANCH"
git config --global alias.push-current-branch "\!git push --set-upstream origin \$(git current-branch)"
git config --global alias.fix-previous "\!git commit --amend --no-edit --date=\"\$(date '+%Y-%m-%dT%H:%M:%S')\""
git config --global pager.log "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight | less"
git config --global pager.show "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight | less"
git config --global pager.diff "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight | less"
git config --global url.git@github.com:.insteadOf https://github.com/
```
