# nixfiles - my NixOS configuration

This is my NixOS config, but you can take inspiration if you want to :)

## Installing

### Setting up environment

you need to enter the live-install environment

```sh
# if you're in the minimal installer you need to install some extra packages
nix-shell -p git nixFlakes
```

```sh
# Enter root shell and use repo as working directory
sudo su -
git clone https://github.com/TomaSajt/nixfiles
cd ./nixfiles

# mount the main filesystem (here labeled `nixos`)
mount /dev/disk/by-label/nixos /mnt
```

### Making a new host configuration

if this is a new host, you are going to have to do some extra setup

```sh
# mount the other disks, like /boot/efi and others
mkdir -p /mnt/boot/efi
mount /dev/<something> /mnt/boot/efi
mkdir -p /mnt/mnt/extra
mount /dev/<something-else> /mnt/mnt/extra
```

```sh
# after this you will need to create the new host's directory inside the git repo
mkdir ./hosts/<hostname>

# copy one of the other hosts's base config (or you can make a new one)
cp ./hosts/<some-other-hostname>/default.nix ./hosts/<hostname>

# generate the host's hardware config (this contains info about mounted disks)
nixos-generate-config --root /mnt --dir ./hosts/<hostname>

# remove unwanted generated file
rm ./hosts/<hostname>/configuration.nix

# add newly made files to git (because flakes can't see them otherwise)
git add .
```

### Setting up the system

```sh
# install system (takes a bit of time)
nixos-install --root /mnt --flake .#<hostname>

# you will get prompted to input the new root password
```

```sh
# if you made changes to the repo make sure to move your nixfiles directory to somewhere on /mnt
mkdir /mnt/etc
cd ..
mv ./nixfiles /mnt/etc
```

you can reboot the system now

### Post-install

after rebooting you will be greeted with the login screen

choose "Other" and log into root with the password you set

once logged in, if you're in the i3 environment press Esc to not generate the i3 config

then press Alt+Enter to open xterm and prepare to have your eyes burned out

```sh
# set the password for the user in this case for `toma`
passwd toma
```

logout using Alt+Shift+E and clicking "Yes" on the i3-nagbar

now log into the user account

```sh
# move nixfiles from where you put them to ~ and transfer permissions
sudo mv /etc/nixfiles ~
sudo chown -R toma:users ~/nixfiles
```

```sh
# setup xrandr (for system tray to show up properly)
xrandr --listmonitors
xrandr --output <monitorname> --primary
```

```sh
# set up soft-link, so you can do nixos-rebuild without specifying the path
sudo ln -s ~/nixfiles/flake.nix /etc/nixos/flake.nix
```
