home
====

home directory config files for easier initial personalization on new boxes

each box should check out its os version branch, and optionally create a new branch from there. merge relevant changes back to os branch, and cherry pick to master if a change can apply to all branches. any branch should be able to merge from master at any point without breaking anything

## Key remapping
Install sezanzeb/key-mapper. Use programmer.json from $HOME/.config/key-mapper/.../

## Drive mapping
`sudo apt-get install cifs-utils`

Add the following to /etc/fstab

```
//192.168.0.10/not-backed-up /home/reese/cloyster-not-backed-up cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/home /home/reese/cloyster-home cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
//192.168.0.10/shared /home/reese/cloyster-shared cifs credentials=/home/reese/.smbcredentials,iocharset=utf8,sec=ntlmssp 0 0
```
