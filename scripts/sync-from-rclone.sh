#! /bin/bash
echo "Syncing ~/Documents ..."
rclone sync remote:rclone-sync/Documents ~/Documents -L -P --interactive
echo ""

echo "Syncing ~/Music ..."
rclone sync remote:rclone-sync/Music ~/Music -L -P --interactive
echo ""

echo "Syncing ~/wallpapers ..."
rclone sync remote:rclone-sync/wallpapers ~/wallpapers -L -P --interactive
echo ""

echo "Syncing ~/.fonts ..."
rclone sync remote:rclone-sync/.fonts ~/.fonts -L -P --interactive
echo ""

