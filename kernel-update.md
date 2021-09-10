Mostly from https://www.reddit.com/r/pop_os/comments/guej8v/tutorial_switchchangeswap_kernels/

Command to replace existing kernel with new kernel of choice. -c is for dry-run, lists commands it will do
```
cd /boot
sudo kernelstub -v -c -k vmlinuz-5.11.17-051117-generic -i initrd.img-5.11.17-051117-generic
```

Following the pattern from the above dry run, you can also add multiple kernels and choose at boot
```
sudo su
cd /boot
cp vmlinuz-5.11.17-051117-generic efi/EFI/Pop_OS-28aecf3c-b61b-42d0-b948-1368f625b58e/
cp initrd.img-5.11.17-051117-generic efi/EFI/Pop_OS-28aecf3c-b61b-42d0-b948-1368f625b58e/
```

Ensure a timeout exists in /boot/efi/loader/loader.conf
```
timeout 3
```

Copy and modify an entry in /boot/efi/loader/entries
