```sh
# Enter root shell and use repo as working directory
sudo su -
cd <this-directory>

# mount the root of the main fs (here labeled `nixos`)
mount /dev/disk/by-label/nixos /mnt

# if this is a new host, you are going to have to do some extra setup

# mount the other disks, like /boot/efi and others
mkdir -p /mnt/boot/efi
mount /dev/<something> /mnt/boot/efi
mkdir -p /mnt/mnt/extra
mount /dev/<something-else> /mnt/mnt/extra

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

# Install system
nixos-install --root /mnt --flake .#<hostname>

# you will get prompted to input the new root password

# if you made changes to the repo make sure 
mkdir /mnt/etc
cd ..
mv ./nixfiles /mnt/etcto move your nixfiles directory to somewhere on /mnt

# we have finished the installation, we can reboot
reboot

# after rebooting you will be greeted with the login screen
# choose "Other" and log into root with the password you set
# once logged in, if you're in the i3 environment do Alt+Enter to open xterm
# now set the password for the user in this case for `toma`
passwd toma

# you are basically done, you just need to log into the user account

# maybe move /etc/nixfiles
sudo mv /etc/nixfiles ~

# setup xrandr (for system tray to show up properly)
xrandr --listmonitors
xrandr --output <monitorname> --primary

# set up soft-link, so you can do nixos-rebuild without specifying the path
sudo ln -s ~/nixfiles/flake.nix /etc/nixos/flake.nix
```
