#!/bin/bash

# 🖨️ Print utility functions for AutoDevKit
# Beautiful formatted output with colors and icons

# Source colors if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

# Print the main application header
print_header() {
    printf "${BRIGHT_PURPLE}\n"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║                  🚀 ${WHITE}AutoDevKit${BRIGHT_PURPLE} 🚀                        ║\n"
    printf "║                                                          ║\n"
    printf "║     ${BRIGHT_CYAN}Choose your technology and get instant setup!${BRIGHT_PURPLE}        ║\n"
    printf "║                                                          ║\n"
    printf "║     ${LIGHT_GRAY}Press '0' at any prompt to exit${BRIGHT_PURPLE}                     ║\n"
    printf "║                                                          ║\n"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "${NC}\n"
}

# Success message with bright green checkmark
print_success() {
    printf "${BRIGHT_GREEN}✅ $1${NC}\n"
}

# Information message with package icon
print_info() {
    printf "${BRIGHT_BLUE}📦 $1${NC}\n"
}

# Warning message with warning icon
print_warning() {
    printf "${BRIGHT_YELLOW}⚠️  $1${NC}\n"
}

# Error message with cross icon
print_error() {
    printf "${BRIGHT_RED}❌ $1${NC}\n"
}

# Configuration display helper
show_config() {
    printf "\n${BRIGHT_GREEN}🎯 Configuration Selected:${NC}\n"
    printf "   ${BRIGHT_CYAN}Project:${NC} ${WHITE}$PROJECT_TYPE${NC}\n"
    printf "   ${BRIGHT_CYAN}Technology:${NC} ${WHITE}$TECHNOLOGY${NC}\n" 
    printf "   ${BRIGHT_CYAN}Demo Mode:${NC} ${WHITE}$DEMO_MODE${NC}\n"
    
    # Add a confirmation prompt with exit option
    printf "\n${YELLOW}📋 Ready to proceed with these settings?${NC}\n"
    printf "  ${GREEN}y)${NC} Yes, let's go!\n"
    printf "  ${BLUE}n)${NC} No, let me change something\n" 
    printf "  ${RED}0)${NC} Exit setup\n"
    printf "\n"
    read -p "${YELLOW}Continue? (y/n, or 0 to exit): ${NC}" CONTINUE_CHOICE
    
    case $CONTINUE_CHOICE in
        [yY]|[yY][eE][sS]|yes|YES)
            printf "${GREEN}✅ Great! Starting setup...${NC}\n"
            ;;
        [nN]|[nN][oO]|no|NO)
            printf "${BLUE}🔄 No problem! Let's start over...${NC}\n\n"
            # Return to main to restart the questions
            main
            exit 0
            ;;
        0|exit|quit|q)
            printf "\n${YELLOW}👋 Setup cancelled. Thanks for trying AutoDevKit!${NC}\n\n"
            exit 0
            ;;
        *)
            printf "\n${RED}❌ Please enter 'y' for yes, 'n' to restart, or '0' to exit.${NC}\n"
            show_config  # Recursive call
            ;;
    esac
}

# Final completion message
show_completion() {
    printf "\n${GREEN}╔══════════════════════════════════════════════════════════╗${NC}\n"
    printf "${GREEN}║                    🎉 SETUP COMPLETE! 🎉                ║${NC}\n"
    printf "${GREEN}║                                                          ║${NC}\n"
    printf "${GREEN}║  ✅ $TECHNOLOGY project configured successfully!${NC}\n"
    printf "${GREEN}║  ✅ Husky + ESLint + Prettier + Commitlint ready!       ║${NC}\n"
    printf "${GREEN}║  ✅ Git hooks active and working!                       ║${NC}\n"
    printf "${GREEN}║  ✅ No deprecation warnings!                            ║${NC}\n"
    if [ "$DEMO_MODE" = "true" ]; then
        printf "${GREEN}║  ✅ Demo completed successfully!                         ║${NC}\n"
    fi
    printf "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}\n"

    printf "\n${CYAN}🎯 Available Commands:${NC}\n"
    printf "   ${YELLOW}npm run lint${NC}          - Check and fix code quality\n"
    printf "   ${YELLOW}npm run format${NC}        - Format all files\n"
    printf "   ${YELLOW}npm run validate${NC}      - Run full validation\n"
    printf "   ${YELLOW}npm test${NC}              - Run tests\n"

    printf "\n${CYAN}📝 Commit Message Format:${NC}\n"
    printf "   ${YELLOW}feat: add new feature${NC}\n"
    printf "   ${YELLOW}fix: resolve bug issue${NC}\n"
    printf "   ${YELLOW}docs: update README${NC}\n"

    printf "\n${GREEN}🚀 Your $TECHNOLOGY development environment is ready!${NC}\n\n"
}

# Export functions for use in other scripts
export -f print_header print_success print_info print_warning print_error show_config show_completion