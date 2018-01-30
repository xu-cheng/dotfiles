# GPG Key

## Generate GPG Key

Ref: https://www.gniibe.org/memo/software/gpg/keygen-25519.html

```bash
gpg --expert --full-gen-key
# Please select what kind of key you want:
#  (9) ECC and ECC
# Please select which elliptic curve you want:
#  (1) Curve 25519
# Please specify how long the key should be valid.
#  10y
```

## Add User ID (a.k.a Email address)

```bash
gpg --expert --edit-key <key id>
# gpg> adduid
# gpg> save
```

## Set Primary User ID

```bash
gpg --expert --edit-key <key id>
# gpg> uid <user id>
# gpg> primary
# gpg> save
```

## Add Subkey (short term signing key)

```bash
gpg --expert --edit-key <key id>
# gpg> addkey
# Please select what kind of key you want:
#  (10) ECC (sign only)
# Please select which elliptic curve you want:
#  (1) Curve 25519
# Please specify how long the key should be valid.
#  2y
# gpg> save
```

## List Key

```
gpg --list-keys --with-subkey-fingerprints
```

## Expert Key

```bash
gpg --output public_key.asc --armor --export <key id>
gpg --armor --export-secret-keys <key id> # output to stdout
```

## Send to Server

```bash
gpg --send-keys <key id>
```
