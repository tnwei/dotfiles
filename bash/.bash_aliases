# Search within text files w/ ripgrep and fzf
alias ff="rg . | fzf"

# Shorthand for apt update, upgrade and autoremove
alias uu="sudo apt update && sudo apt -y upgrade && sudo apt autoremove"

# To grep TODOs in files
# -I ignores binary
# -R is recursive
# -n is no idea what it is
alias todo="grep TODO -nRI --exclude=*.csv *"

# Quick and dirty conversion of markdown to PDF using LaTeX
# Requires pandoc!
# Example: md2pdf file.md file.pdf
md2pdf () {
    pandoc -V geometry:margin=1in -f markdown+hard_line_breaks -o $2 $1
}

# Similar but pipes straight to zathura
md2zathura(){
    cat $1 | pandoc -V geometry:margin=1in -f markdown+hard_line_breaks -w pdf | zathura -
}

# cURL an URL and get response time
# ref: https://stackoverflow.com/a/22625150/13095028
curltime () {
    curl -w @- -o /dev/null -s "$1" <<'EOF'
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
    time_appconnect:  %{time_appconnect}\n
   time_pretransfer:  %{time_pretransfer}\n
      time_redirect:  %{time_redirect}\n
 time_starttransfer:  %{time_starttransfer}\n
                   ----------\n
         time_total:  %{time_total}\n
EOF
}
