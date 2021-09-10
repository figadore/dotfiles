home
====

home directory config files for easier initial personalization on new boxes

each box should check out its os version branch, and optionally create a new branch from there. merge relevant changes back to os branch, and cherry pick to master if a change can apply to all branches. any branch should be able to merge from master at any point without breaking anything

## Key remapping
Modify .Xmodmap as desired

Run `xmodmap .Xmodmap && xkbcomp $DISPLAY $HOME/.xkbmap-programmer`

Set a startup command or cron job to run `xkbcomp /home/reese/.xkbmap-programmer ":1"` (`":1"` can be replaced with `$DISPLAY"` in some situations)

## Drive mapping
`sudo apt-get install cifs-utils`

Add the following to /etc/fstab

```
//192.168.0.10/not-backed-up /home/reese/cloyster-not-backed-up cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/home /home/reese/cloyster-home cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/shared /home/reese/cloyster-shared cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
```
