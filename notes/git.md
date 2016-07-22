Git Settings
============

## Generate SSH Key

* Run Command below to generate the key:

```bash
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/github_rsa -C "your_email@youremail.com"
```
* Add below content to `~/.ssh/config`:

```
Host github github.com
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
