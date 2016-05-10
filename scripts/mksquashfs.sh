#!/bin/bash

# Import version
source ../version

#
echo "Generating a squashfs for ..."
mksquashfs . /mnt/nvros/mnt/data1/nvros.squashfs.${VERSION} -b 1M -comp xz -Xdict-size 100% -ef 
