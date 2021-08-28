for f in *; do
    if [ -d "$f" ]; then
        stow -D "$f"
    fi
done

