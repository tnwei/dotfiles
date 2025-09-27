#! /bin/bash
echo "Syncing ~/Documents ..."
rclone sync ~/Documents remote:rclone-sync/Documents -L -P --interactive
echo ""

echo "Syncing ~/Music ..."
rclone sync ~/Music remote:rclone-sync/Music -L -P --interactive
echo ""

echo "Syncing ~/wallpapers ..."
rclone sync ~/wallpapers remote:rclone-sync/wallpapers -L -P --interactive
echo ""

echo "Syncing ~/.fonts ..."
rclone sync ~/.fonts remote:rclone-sync/.fonts -L -P --interactive
echo ""
