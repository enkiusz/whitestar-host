#!/bin/sh

readonly SRCDIR=$HOME/devices/whitestar/archive
shopt -q nullglob

if [ -z "$WIGLE_USERNAME" -o -z "$WIGLE_PASSWORDFILE" ]; then
    echo "WIGLE_USERNAME and WIGLE_PASSWORD environment variables need to be set" >&2
    exit 1
fi

echo "Uploading files inside '$SRCDIR' as '$WIGLE_USERNAME'" >&2

# Gzip uncompressed tars, wigle.net only processes .tar.gz files properly
for t in $SRCDIR/kismet-*.tar; do
    gzip $t
done

systemd-inhibit --what=idle $HOME/bin/wiglenet-uploader.py -l "$WIGLE_USERNAME" -p "$WIGLE_PASSWORDFILE" --rename-imported=.imported-successfuly -- $SRCDIR/kismet-*.tar.gz
