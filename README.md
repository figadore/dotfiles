home
====

home directory config files for easier initial personalization on new boxes

each box should check out its os version branch, and optionally create a new branch from there. merge relevant changes back to os branch, and cherry pick to master if a change can apply to all branches. any branch should be able to merge from master at any point without breaking anything

## Key remapping
Install sezanzeb/input-remapper. Use programmer.json from $HOME/.config/input-remapper/.../

## Drive mapping
`sudo apt-get install cifs-utils`

Add the following to /etc/fstab

```
//192.168.0.10/not-backed-up /home/reese/cloyster-not-backed-up cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/home /home/reese/cloyster-home cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/shared /home/reese/cloyster-shared cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
```

## USB Storage
Add the following lines to /etc/modprobe.d/blacklist.conf
```
# For vivantehealth security policies, disable external usb storage
blacklist usb_storage
```

Create /usr/local/bin/disablestorage
```
#!/bin/bash
modprobe -r uas
modprobe -r usb_storage
# something for sd card reader
```

Create /lib/systemd/system/disable-usb.service
```
[Unit]
#After=network.service
Description=Runs /usr/local/bin/disablestorage

[Service]
ExecStart=/usr/local/bin/disablestorage

[Install]
WantedBy=default.target
```

Symlink to /etc/systemd/system
```
cd /etc/systemd/system
sudo ln -s /lib/systemd/system/disable-usb.service
```

Start it
```
systemctl start disable-usb
systemctl enable disable-usb
reboot
```

## SD Card reader
TODO
