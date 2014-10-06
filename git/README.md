Git Settings
============

## Generate SSH Key

* Run Command below to generate the key:

```bash
$ ssh-keygen -t rsa -f ~/.ssh/github_rsa -C "your_email@youremail.com"
```
* Add below content to `~/.ssh/config`:

```
Host github.com
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
$ ssh -T git@github.com
```

## Set Git Config

Run below commands:

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@yourmail.com"
git config --global core.excludesfile '~/.gitignore'
git config --global core.autocrlf input
git config --global core.editor "subl -w"
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.diff auto
git config --global color.grep auto
git config --global color.showbranch auto
git config --global color.ui auto
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
```
