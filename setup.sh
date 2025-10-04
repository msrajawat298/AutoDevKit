#!/bin/bash

# 🚀 AutoDevKit - Interactive Development Environment Setup (Refactored)
# Supports: React.js, React Native, Node.js, and general projects
# Features: Interactive setup, demo mode, auto-configuration
# Architecture: Modular design with separated concerns

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import all modular components
source "${SCRIPT_DIR}/scripts/ui/colors.sh"
source "${SCRIPT_DIR}/scripts/ui/print.sh"
source "${SCRIPT_DIR}/scripts/ui/prompts.sh"
source "${SCRIPT_DIR}/scripts/config/package.sh"
source "${SCRIPT_DIR}/scripts/config/gitignore.sh"
source "${SCRIPT_DIR}/scripts/config/eslint.sh"
source "${SCRIPT_DIR}/scripts/config/prettier.sh"
source "${SCRIPT_DIR}/scripts/config/husky.sh"
source "${SCRIPT_DIR}/scripts/config/lint-staged.sh"
source "${SCRIPT_DIR}/scripts/config/commitlint.sh"
source "${SCRIPT_DIR}/scripts/core/git.sh"
source "${SCRIPT_DIR}/scripts/core/dependencies.sh"
source "${SCRIPT_DIR}/scripts/demo/demo.sh"

# Main execution orchestrator
main() {
    # Phase 1: User interaction and configuration
    print_header
    ask_project_type
    ask_technology  
    ask_demo_mode
    show_config
    
    printf "\n${BLUE}📦 Starting setup for $TECHNOLOGY project...${NC}\n"
    
    # Phase 2: Core setup
    init_git
    create_package_json
    create_gitignore
    install_dependencies
    
    # Phase 3: Tool configuration
    setup_husky
    setup_eslint_config
    setup_prettier
    setup_lint_staged
    setup_commitlint
    setup_git_hooks
    
    # Phase 4: Demo and completion
    create_demo_files
    run_demo
    show_completion
}

# Export the main function for potential external use
export -f main

# Run the script only if executed directly (not sourced)
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi