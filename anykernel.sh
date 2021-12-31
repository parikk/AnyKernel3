# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=eun kernel for Samsung m20lte
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=10-11-12
'; } # end properties

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

# mount system and vendor
mount /system_root;
mount -o rw,remount /vendor;

# Find device/rom and copy kernel
device_name="$(grep ro.product.vendor.device /vendor/build.prop | cut -d'=' -f2)";
if grep PDA /system_root/system/build.prop; then
cp -f "$home/Image_$device_name-oneui" "$home/Image";
else
cp -f "$home/Image_$device_name" "$home/Image";
fi

write_boot;

echo "/dev/block/zram0 none swap defaults zramsize=50%,max_comp_streams=8" >/vendor/fstab.enableswap;
echo "on boot
    setprop ro.config.low_ram false
    setprop ro.lmk.low 1001
    setprop ro.lmk.medium 0
    setprop ro.lmk.critical 0
    setprop ro.lmk.critical_upgrade false
    setprop ro.lmk.upgrade_pressure 100
    setprop ro.lmk.downgrade_pressure 100
    setprop ro.lmk.kill_heaviest_task true
    setprop ro.lmk.kill_timeout_ms 100
    setprop ro.lmk.use_minfree_levels true
    setprop ro.lmk.log_stats true
on property:sys.boot_completed=1
    swapon_all /vendor/fstab.enableswap
    write /proc/sys/vm/swappiness 100
    write /proc/sys/vm/page-cluster 0" >/vendor/etc/init/swap.rc;
chmod 644 /vendor/fstab.enableswap;
chmod 644 /vendor/etc/init/swap.rc;

## end install
