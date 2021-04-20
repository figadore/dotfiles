home
====

home directory config files for easier initial personalization on new boxes

each box should check out its os version branch, and optionally create a new branch from there. merge relevant changes back to os branch, and cherry pick to master if a change can apply to all branches. any branch should be able to merge from master at any point without breaking anything

## Key remapping
Set a startup command to run `xkbcomp /home/reese/.xkbmap-programmer ":1"` (check if `":1"` can be replaced with `$DISPLAY"`
