#!/bin/bash

# 🖨️ Print utility functions for AutoDevKit
# Beautiful formatted output with colors and icons

# Source colors if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

# Print the main application header
print_header() {
    printf "${PURPLE}\n"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║                  🚀 AutoDevKit 🚀                        ║\n"
    printf "║                                                          ║\n"
    printf "║     Choose your technology and get instant setup!        ║\n"
    printf "║                                                          ║\n"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "${NC}\n"
}

# Success message with green checkmark
print_success() {
    printf "${GREEN}✅ $1${NC}\n"
}

# Information message with package icon
print_info() {
    printf "${BLUE}📦 $1${NC}\n"
}

# Warning message with warning icon
print_warning() {
    printf "${YELLOW}⚠️  $1${NC}\n"
}

# Error message with cross icon
print_error() {
    printf "${RED}❌ $1${NC}\n"
}

# Configuration display helper
show_config() {
    printf "\n${GREEN}🎯 Configuration Selected:${NC}\n"
    printf "   Project: ${YELLOW}$PROJECT_TYPE${NC}\n"
    printf "   Technology: ${YELLOW}$TECHNOLOGY${NC}\n" 
    printf "   Demo Mode: ${YELLOW}$DEMO_MODE${NC}\n"
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