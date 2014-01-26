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

* Upload public key to Github.

## Set Git Config

Run below commands:

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@yourmail.com"
git config --global core.autocrlf input
git config --global core.editor "subl -w"
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.diff auto
git config --global color.grep auto
git config --global color.showbranch auto
git config --global color.ui auto
```
