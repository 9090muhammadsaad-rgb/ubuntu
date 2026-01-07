#!/bin/bash

# Colors for styling
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner Function
show_banner() {
    clear
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${GREEN}      UBUNTU GUI INSTALLER FOR TERMUX  ${NC}"
    echo -e "${BLUE}=======================================${NC}"
}

# Install GUI Function
install_gui() {
    echo -e "${GREEN}[*] System update ho raha hai...${NC}"
    apt update && apt upgrade -y

    echo -e "${GREEN}[*] Zaroori Tools install ho rahe hain (Sudo, VNC, XFCE4)...${NC}"
    # Minimal GUI (XFCE4 is lightweight and best for Termux)
    apt install sudo tigervnc-standalone-server xfce4 xfce4-goodies -y

    echo -e "${GREEN}[*] Firefox Browser install ho raha hai...${NC}"
    apt install firefox -y

    # Setting up VNC Password
    echo -e "${BLUE}[!] VNC Password set karein (yad rakhiyega):${NC}"
    vncpasswd

    # Create VNC Startup Script
    mkdir -p ~/.vnc
    echo "#!/bin/bash
startxfce4 &" > ~/.vnc/xstartup
    chmod +x ~/.vnc/xstartup

    echo -e "${GREEN}=======================================${NC}"
    echo -e "${GREEN}[SUCCESS] GUI Setup Complete!${NC}"
    echo -e "${BLUE}Command to start: vncserver -localhost no :1${NC}"
    echo -e "${BLUE}Connect on VNC Viewer App: localhost:5901${NC}"
    echo -e "${GREEN}=======================================${NC}"
    read -p "Press Enter to go back..."
}

# Uninstall GUI Function
uninstall_gui() {
    echo -e "${RED}[!] GUI aur Firefox remove ho raha hai...${NC}"
    apt remove tigervnc-standalone-server xfce4 xfce4-goodies firefox -y
    apt autoremove -y
    rm -rf ~/.vnc
    echo -e "${GREEN}[+] Sab kuch clean ho gaya!${NC}"
    read -p "Press Enter to go back..."
}

# Main Menu
while true; do
    show_banner
    echo "1) Install GUI (XFCE4 + Firefox + VNC)"
    echo "2) Uninstall GUI"
    echo "3) Exit"
    echo -e "${BLUE}---------------------------------------${NC}"
    read -p "Option select karein [1-3]: " choice

    case $choice in
        1) install_gui ;;
        2) uninstall_gui ;;
        3) exit ;;
        *) echo -e "${RED}Invalid option!${NC}" && sleep 1 ;;
    esac
done
# (C) Saad Owner 
# Plese Subscribe & Like
