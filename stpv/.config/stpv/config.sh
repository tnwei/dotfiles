#       function     type  dep     dep-image
add_top handle_ipynb ipynb nbread  -
handle_ipynb() {
    [ "$file_extension_lower" = ipynb ] ||
        return "$RET_NO_MATCH"

    nbread "$file_path" --pager
}
