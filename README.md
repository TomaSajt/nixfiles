### Install a profile
```sh
# Enter root shell and use repo as working directory
sudo su -
cd <this-directory>
```

```sh
# Mount the root of the main fs
# Example:
mount /dev/disk/by-label/nixos /mnt
```

```sh
# if this is a new host, you are going to have to do some extra setup

# mount the other disks, like /boot/efi and others
mount /dev/<something> /mnt/boot/efi

# after this you will need to create the new host's directory inside the git repo
mkdir ./hosts/<hostname>

# copy one of the other hosts's base config (or you can make a new one)
cp ./hosts/<some-other-hostname>/default.nix ./hosts/<hostname>/default.nix

# generate the host's hardware config (this contains info about mounted disks)
nixos-generate-config --root /mnt --dir ./hosts/<hostname>/hardware-configuration.nix
```

```sh
# Install system
nixos-install --root /mnt --flake .#<hostname>
```
you will get prompted to input the root password

reboot, log into root, do `passwd <username>` to change password

### Make soft-link
Run the following command to make a soft-link to the nixfiles directory

```sh
sudo ln -s /absolute/path/to/this/folder/flake.nix /etc/nixos/flake.nix
```
