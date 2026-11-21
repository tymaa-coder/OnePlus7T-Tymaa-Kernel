#!/system/bin/sh
MODDIR=${0%/*}
CONFIG_FILE="$MODDIR/se_mode.conf"
if [ -f "$CONFIG_FILE" ]; then
    MODE=$(cat "$CONFIG_FILE" 2>/dev/null | tr -d '\r\n')
else
    MODE=2
fi
case "$MODE" in
    1) echo 1 > /sys/fs/selinux/enforce 2>/dev/null; setprop ro.boot.selinux enforcing 2>/dev/null ;;
    2) echo 0 > /sys/fs/selinux/enforce 2>/dev/null; setprop ro.boot.selinux permissive 2>/dev/null ;;
esac
log -t SELinuxSwitcher "Boot: Applied mode $MODE ($(getenforce 2>/dev/null || echo 'unknown'))"