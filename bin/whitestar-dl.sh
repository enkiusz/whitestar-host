#!/bin/sh

readonly SRCDIR=/mnt/whitestar
readonly DESTDIR=$HOME/devices/whitestar
readonly DIRS="archive"
mount "$SRCDIR"
shopt -q nullglob

echo "Downloading files from '$SRCDIR' to '$DESTDIR'" >&2

pushd "$SRCDIR"
for path in $DIRS; do
    tgtdir="$DESTDIR/$path"
    mkdir -p "$tgtdir"; pushd "$tgtdir"; rsync --remove-source-files -av "$SRCDIR/$path/" "$DESTDIR/$path"; popd
done
popd

umount "$SRCDIR" || true
