#! /bin/bash

 mkdir loopdir
 mount -o loop *.iso loopdir
 mkdir cd
 echo Please Wait Several Mins
 rsync -a -H --exclude=TRANS.TBL loopdir/ cd
 umount loopdir
 rmdir loopdir
 mkdir irmod
 cd irmod
 gzip -d < ../cd/install.amd/initrd.gz | \
        cpio --extract --verbose --make-directories --no-absolute-filenames
 cp ../preseed.cfg preseed.cfg
 find . | cpio -H newc --create --verbose | \
        gzip -9 > ../cd/install.amd/initrd.gz
 cd ../
 rm -fr irmod/
  cp isolinux.cfg cd/isolinux/isolinux.cfg
  cd cd
  md5sum `find -follow -type f` > md5sum.txt
  cd ..

 genisoimage -o Test.iso -r -J -no-emul-boot -boot-load-size 4 \
 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat ./cd
 rm -fr cd
 echo Done
