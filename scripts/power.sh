# Capture all command-line arguments passed to the main script
args="$@"

# Check if ENV_VAR is set to value1
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    # Call script1.sh with all arguments passed to the main script
    ./power-hyprland.sh $args
else
    # Call script2.sh with all arguments passed to the main script
    ./power-basic.sh $args
fi
