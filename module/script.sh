#!/system/bin/sh
MODDIR=${0%/*}
CONFIG_FILE="$MODDIR/se_mode.conf"
clear
echo "========================================="
echo "   SELinux Mode Switcher (Tymaa Kernel)  "
echo "   Kernel: $(uname -r 2>/dev/null || echo 'unknown')"
echo "   Current: $(getenforce 2>/dev/null || echo 'unknown')"
echo "========================================="
echo ""
echo "  1) Enforcing   — blocks, logs"
echo "  2) Permissive  — allows, logs (default)"
echo "  3) Disabled    — requires SEPARATE kernel build"
echo "  0) Exit"
echo ""
printf "Select [1-3, 0]: "
read -r CHOICE
case "$CHOICE" in
    1) echo 1 > "$CONFIG_FILE"; echo 1 > /sys/fs/selinux/enforce 2>/dev/null; setprop ro.boot.selinux enforcing 2>/dev/null; MSG="Enforcing" ;;
    2) echo 2 > "$CONFIG_FILE"; echo 0 > /sys/fs/selinux/enforce 2>/dev/null; setprop ro.boot.selinux permissive 2>/dev/null; MSG="Permissive" ;;
    3) echo ""; echo "[!] Disabled = separate kernel build needed"; echo "    Flash kernel_7t_Tymaa_Disabled.zip"; read -p "Press Enter..."; exit 0 ;;
    *) exit 0 ;;
esac
echo ""; echo "[✅] Set: $MSG"; echo "    Current: $(getenforce 2>/dev/null)"; echo "Rebooting in 3 sec..."; sleep 3; reboot