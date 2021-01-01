# Shorthand for apt update, upgrade and autoremove
alias uu="sudo apt update && sudo apt -y upgrade && sudo apt autoremove"

# To grep TODOs in files
# -I ignores binary
# -R is recursive
# -n is no idea what it is
alias todo="grep TODO -nRI *"

# Quick and dirty conversion of markdown to PDF using LaTeX
# Requires pandoc!
# Example: md2pdf file.md file.pdf
md2pdf () {
    pandoc -V geometry:margin=1in -f markdown+hard_line_breaks -o $2 $1
}
