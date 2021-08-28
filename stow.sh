for f in *; do
    if [ -d "$f" ]; then
        stow "$f"
    fi
done
