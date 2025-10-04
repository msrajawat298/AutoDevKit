#!/bin/bash

# 🔧 Git operations for AutoDevKit
# Handles Git repository initialization and management

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Initialize Git repository if needed
init_git() {
    if [ "$PROJECT_TYPE" = "fresh" ] && [ ! -d ".git" ]; then
        print_info "Initializing Git repository..."
        git init
        print_success "Git repository initialized!"
    fi
}

# Export functions
export -f init_git