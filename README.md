### Install a profile
```sh
# Enter root shell
sudo su -
```

```sh
# Mount the stuff you need
# Example:
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot/efi
mount /dev/disk/by-uuid/<some_uuid_here> /mnt/boot/efi
```

```sh
# Install system
nixos-install --root /mnt --flake <path_to_this_directory>#<some_host_name_here>
```
you will get prompted to input the root password

reboot, log into root, do `passwd <username>` to change password

### Make soft-link
Run the following command to make a soft-link to the nixfiles directory

```sh
sudo ln -s /absolute/path/to/this/folder/flake.nix /etc/nixos/flake.nix
```
