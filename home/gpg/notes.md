Useful commands
```sh
# create new key-pair
gpg --full-generate-key
```

```sh
# list owned secret keys
gpg --list-secret-keys --keyid-format=long
```

```sh
# Get public key as text
gpg --armor --export <key_id_here>
```
