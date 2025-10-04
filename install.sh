#!/bin/bash

# 🚀 AutoDevKit Installer - Downloads and sets up the complete modular toolkit
# Usage: curl -fsSL https://raw.githubusercontent.com/msrajawat298/AutoDevKit/main/install.sh | bash

set -e

# Colors for installer output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    printf "${BLUE}📦 $1${NC}\n"
}

print_success() {
    printf "${GREEN}✅ $1${NC}\n"
}

print_error() {
    printf "${RED}❌ $1${NC}\n"
}

print_header() {
    printf "${BLUE}\n"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║              🚀 AutoDevKit Installer 🚀                  ║\n"
    printf "║                                                          ║\n"
    printf "║          Downloading modular development toolkit          ║\n"
    printf "║                                                          ║\n"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "${NC}\n"
}

# Create installation directory
setup_directory() {
    INSTALL_DIR="autodevkit"
    if [ -d "$INSTALL_DIR" ]; then
        print_info "Directory $INSTALL_DIR already exists. Creating backup..."
        mv "$INSTALL_DIR" "${INSTALL_DIR}.backup.$(date +%s)"
    fi
    
    mkdir -p "$INSTALL_DIR"
    cd "$INSTALL_DIR"
    print_success "Created installation directory: $INSTALL_DIR"
}

# Download files from GitHub
download_files() {
    local base_url="https://raw.githubusercontent.com/msrajawat298/AutoDevKit/main"
    
    print_info "Downloading AutoDevKit files..."
    
    # Create directory structure
    mkdir -p scripts/{ui,config,core,demo}
    mkdir -p examples
    
    # Download main files
    curl -fsSL "$base_url/setup.sh" -o setup.sh
    curl -fsSL "$base_url/README.md" -o README.md
    curl -fsSL "$base_url/MODULAR_ARCHITECTURE.md" -o MODULAR_ARCHITECTURE.md
    curl -fsSL "$base_url/SHARING_GUIDE.md" -o SHARING_GUIDE.md
    curl -fsSL "$base_url/CHANGELOG.md" -o CHANGELOG.md
    curl -fsSL "$base_url/CONTRIBUTING.md" -o CONTRIBUTING.md
    curl -fsSL "$base_url/LICENSE" -o LICENSE
    
    # Download scripts
    curl -fsSL "$base_url/scripts/ui/colors.sh" -o scripts/ui/colors.sh
    curl -fsSL "$base_url/scripts/ui/print.sh" -o scripts/ui/print.sh
    curl -fsSL "$base_url/scripts/ui/prompts.sh" -o scripts/ui/prompts.sh
    
    curl -fsSL "$base_url/scripts/config/package.sh" -o scripts/config/package.sh
    curl -fsSL "$base_url/scripts/config/gitignore.sh" -o scripts/config/gitignore.sh
    curl -fsSL "$base_url/scripts/config/eslint.sh" -o scripts/config/eslint.sh
    curl -fsSL "$base_url/scripts/config/prettier.sh" -o scripts/config/prettier.sh
    curl -fsSL "$base_url/scripts/config/husky.sh" -o scripts/config/husky.sh
    curl -fsSL "$base_url/scripts/config/lint-staged.sh" -o scripts/config/lint-staged.sh
    curl -fsSL "$base_url/scripts/config/commitlint.sh" -o scripts/config/commitlint.sh
    
    curl -fsSL "$base_url/scripts/core/git.sh" -o scripts/core/git.sh
    curl -fsSL "$base_url/scripts/core/dependencies.sh" -o scripts/core/dependencies.sh
    
    curl -fsSL "$base_url/scripts/demo/demo.sh" -o scripts/demo/demo.sh
    
    # Download examples
    curl -fsSL "$base_url/examples/README.md" -o examples/README.md
    
    print_success "All files downloaded successfully!"
}

# Make scripts executable
make_executable() {
    chmod +x setup.sh
    chmod +x scripts/ui/*.sh
    chmod +x scripts/config/*.sh
    chmod +x scripts/core/*.sh
    chmod +x scripts/demo/*.sh
    
    print_success "Made all scripts executable"
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."
    
    # Check if all required files exist
    local required_files=(
        "setup.sh"
        "scripts/ui/colors.sh"
        "scripts/ui/print.sh"
        "scripts/ui/prompts.sh"
        "scripts/config/package.sh"
        "scripts/core/git.sh"
    )
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            print_error "Missing required file: $file"
            return 1
        fi
    done
    
    print_success "Installation verified successfully!"
}

# Main installer function
main() {
    print_header
    
    # Check dependencies
    if ! command -v curl >/dev/null 2>&1; then
        print_error "curl is required but not installed. Please install curl and try again."
        exit 1
    fi
    
    setup_directory
    download_files
    make_executable
    verify_installation
    
    printf "\n${GREEN}╔══════════════════════════════════════════════════════════╗${NC}\n"
    printf "${GREEN}║                 🎉 INSTALLATION COMPLETE! 🎉            ║${NC}\n"
    printf "${GREEN}║                                                          ║${NC}\n"
    printf "${GREEN}║  AutoDevKit has been successfully installed!            ║${NC}\n"
    printf "${GREEN}║                                                          ║${NC}\n"
    printf "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}\n"
    
    printf "\n${BLUE}🚀 To get started:${NC}\n"
    printf "   ${YELLOW}cd $INSTALL_DIR${NC}\n"
    printf "   ${YELLOW}./setup.sh${NC}\n"
    
    printf "\n${BLUE}📚 Documentation:${NC}\n"
    printf "   ${YELLOW}cat README.md${NC}\n"
    printf "   ${YELLOW}cat MODULAR_ARCHITECTURE.md${NC}\n"
    
    printf "\n${GREEN}Happy coding! 🎯${NC}\n\n"
}

# Run the installer
main "$@"