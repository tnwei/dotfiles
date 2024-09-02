#! /bin/bash

# Manually install
# glow stpv lf neo zoxide fd

CORE_PKGS=(
    "gcc"
    "bat"
    "ranger"
    "htop"
    "neofetch"
    "tldr"
    "ripgrep"
    "fzf"
    "make"
    "pipx"
    "tmux"
    "vim"
    "stow"
    "neovim"
)

PIPX_PKGS=(
    "black"
    "cookiecutter"
    "nbdime"
    "pre-commit"
    "dtrx"
    "git+https://github.com/tnwei/nbread"
)

HYPRLAND_PKGS=(
    "hyprland"
    "wl-clipboard"
    "waybar"
    "gnome-tweaks"
    "swaybg"
    "polkit-gnome"
    "dunst"
    "swaylock"
    "grim"
    "slurp"
    "wofi"
    "foot"
    "swayidle"
    "blueman"
    "chafa"
    "pavucontrol"
    "pipewire"
    "wireplumber"
    "zathura"
    "zathura-pdf-mupdf"
    "vlc"
    "pinta"
    "swappy"
)

PERSONAL_PC_PKGS=(
    "syncthing" "hugo" "transmission"
)



# Determine which system
if [ -e /etc/fedora-release ]; then
    PKGMAN="dnf"
elif [ -e /etc/lsb-release ] || [ -e /etc/lsb-release.d/ubuntu ]; then
    PKGMAN="apt"
else
    echo "Unsupported distribution"
    exit
fi

PKGS_TO_INSTALL=()

# Print core packages to be installed
echo -e "Following are core packages:\n"
echo ${CORE_PKGS[*]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_CORE

    if [[ $ADD_CORE == "y" ]]; then
        PKGS_TO_INSTALL+=( "${CORE_PKGS[@]}" )
        echo ""
        break
    elif [[ $ADD_CORE == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done


# Ask if want to install hyprland packages
echo -e "Following are Hyprland packages:\n"
echo ${HYPRLAND_PKGS[*]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_HYPRLAND

    if [[ $ADD_HYPRLAND == "y" ]]; then
        PKGS_TO_INSTALL+=( "${HYPRLAND_PKGS[@]}" )
        echo ""
        break
    elif [[ $ADD_HYPRLAND == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done


# Ask if want to install personal packages
echo -e "Following are packages for personal PCs only:\n"
echo ${PERSONAL_PC_PKGS[*]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_PERSONAL_PC

    if [[ $ADD_PERSONAL_PC == "y" ]]; then
        PKGS_TO_INSTALL+=( "${PERSONAL_PC_PKGS[@]}" )
        echo ""
        break
    elif [[ $ADD_PERSONAL_PC == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done


# Run package manager installs
if [ ${#PKGS_TO_INSTALL[@]} -ne 0 ]; then
    sudo $PKGMAN install ${PKGS_TO_INSTALL[*]}
    echo ""
else
    echo "Skipping $PKGMAN install"
    echo ""
fi

# Run pipx installs
echo -e "The following packages will be installed by pipx:\n"
echo ${PIPX_PKGS[@]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_PIPX

    if [[ $ADD_PIPX == "y" ]]; then
        for package in "${PIPX_PKGS[@]}"; do
            pipx install $package
        done
        echo ""
        break
    elif [[ $ADD_PIPX == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done
