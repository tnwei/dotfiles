#! /bin/bash

# Still have to manually install
# glow stpv lf neo

# Associative array for gh_tools
declare -A GH_TOOLS

GH_TOOLS["uv"]="curl -LsSf https://astral.sh/uv/install.sh | sh"
GH_TOOLS["zoxide"]="curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
GH_TOOLS["pnpm"]="curl -fsSL https://get.pnpm.io/install.sh | sh -"
GH_TOOLS["vim-plug"]="curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

CORE_PKGS=(
    "golang"
    "gcc"
    "bat"
    "ranger"
    "htop"
    "fastfetch"
    "tldr"
    "ripgrep"
    "fzf"
    "make"
    "tmux"
    "vim"
    "stow"
    "neovim"
    "rclone"
    "lmsensors"
)

PIPX_PKGS=(
    "ruff"
    "cookiecutter"
    "nbdime"
    "pre-commit"
    "dtrx"
    "git+https://github.com/tnwei/nbread"
)

HYPRLAND_DESKTOP_PKGS=(
    # sudo dnf copr enable solopasha/hyprland
    "hyprland"
    "hyprlock"
    "hypridle"
    "hyprpicker"
    "wl-clipboard"
    "waybar"
    "network-manager-applet"
    "NetworkManager-tui"
    "gnome-tweaks"
    "swaybg"
    # https://discussion.fedoraproject.org/t/polkit-agent-in-hyprland-fedora-41/136857
    # "polkit-gnome"
    "mate-polkit"
    "dunst"
    "grim"
    "slurp"
    "foot"
    "blueman"
    "chromium"
    "firefox"
    "chafa"
    "acpi"
    "pavucontrol"
    "pipewire"
    "wireplumber"
    "zathura"
    "zathura-pdf-mupdf"
    "vlc"
    "pinta"
    "swappy"
    "fuzzel"
)

PERSONAL_PC_PKGS=(
    "hugo" "transmission"
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
echo ${HYPRLAND_DESKTOP_PKGS[*]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_HYPRLAND

    if [[ $ADD_HYPRLAND == "y" ]]; then
        PKGS_TO_INSTALL+=( "${HYPRLAND_DESKTOP_PKGS[@]}" )
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

# Run gh tool installs
echo -e "The following tools will be installed with the following commands:\n"
for tool in "${!GH_TOOLS[@]}"; do
    echo "- $tool: ${GH_TOOLS[$tool]}"
done
echo ""

while true; do
    read -p "Would you like to install them? (y/n) " INSTALL_GH_TOOLS

    if [[ $INSTALL_GH_TOOLS == "y" ]]; then
        # Install each tool
        for tool in "${!GH_TOOLS[@]}"; do
            echo "Installing $tool..."
            eval "${GH_TOOLS[$tool]}"
            echo "$tool installation completed."
            echo ""
        done
        break
    elif [[ $INSTALL_GH_TOOLS == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done

# Run pipx installs
echo -e "The following packages will be installed with "uv" (ensure is installed!):\n"
echo ${PIPX_PKGS[@]}
echo ""

while true; do
    read -p  "Would you like to install them? (y/n) " ADD_PIPX

    if [[ $ADD_PIPX == "y" ]]; then
        for package in "${PIPX_PKGS[@]}"; do
            uv tool install $package --force
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

# Setup bash configuration
echo -e "Setting up bash configuration (.common_bashrc and .bash_aliases)...\n"

while true; do
    read -p "Would you like to add .common_bashrc and .bash_aliases to ~/.bashrc? (y/n) " SETUP_BASH

    if [[ $SETUP_BASH == "y" ]]; then
        # Backup existing .bashrc if it exists
        if [ -f ~/.bashrc ]; then
            cp ~/.bashrc ~/.bashrc.backup
            echo "Backed up existing ~/.bashrc to ~/.bashrc.backup"
        fi

        # Add sourcing commands to ~/.bashrc
        echo "" >> ~/.bashrc
        echo "# Added by dotfiles install script" >> ~/.bashrc
        echo "if [ -f ~/.common_bashrc ]; then" >> ~/.bashrc
        echo "    . ~/.common_bashrc" >> ~/.bashrc
        echo "fi" >> ~/.bashrc
        echo "" >> ~/.bashrc
        echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
        echo "    . ~/.bash_aliases" >> ~/.bashrc
        echo "fi" >> ~/.bashrc

        echo "Added .common_bashrc and .bash_aliases sourcing to ~/.bashrc"
        echo "Run 'source ~/.bashrc' to reload your bash configuration"
        echo ""
        break
    elif [[ $SETUP_BASH == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done

# Setup git configuration
echo -e "Setting up git configuration (.gitmyconfig)...\n"

while true; do
    read -p "Would you like to add .gitmyconfig include to ~/.gitconfig? (y/n) " SETUP_GIT

    if [[ $SETUP_GIT == "y" ]]; then
        # Check if ~/.gitconfig already includes .gitmyconfig
        if [ -f ~/.gitconfig ] && grep -q "path.*gitmyconfig" ~/.gitconfig; then
            echo "~/.gitconfig already includes .gitmyconfig"
        else
            # Backup existing .gitconfig if it exists
            if [ -f ~/.gitconfig ]; then
                cp ~/.gitconfig ~/.gitconfig.backup
                echo "Backed up existing ~/.gitconfig to ~/.gitconfig.backup"
            fi

            # Add include section to ~/.gitconfig
            echo "" >> ~/.gitconfig
            echo "# Added by dotfiles install script" >> ~/.gitconfig
            echo "[include]" >> ~/.gitconfig
            echo "    path = ~/.gitmyconfig" >> ~/.gitconfig

            echo "Added .gitmyconfig include to ~/.gitconfig"
        fi
        echo ""
        break
    elif [[ $SETUP_GIT == "n" ]]; then
        echo ""
        break
    else
        echo "Invalid input, y/n only"
    fi
done
