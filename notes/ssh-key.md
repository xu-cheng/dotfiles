# SSH Key

## Generate SSH Key

```bash
# RSA Key for compatibility
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "your_email@youremail.com"
# EdDSA Key for performance
$ ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519 -C "your_email@youremail.com"
```

## Add key to ssh-agent

```bash
$ ssh-add -K /path/to/private_key
```

