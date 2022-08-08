# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=1
device.name1=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=auto;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel boot install
split_boot;
flash_boot;
flash_dtbo;
## end boot install