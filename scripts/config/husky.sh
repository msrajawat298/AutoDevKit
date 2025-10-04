#!/bin/bash

# 🐕 Husky configuration generator for AutoDevKit
# Sets up Git hooks with Husky

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Setup Husky for Git hooks
setup_husky() {
    print_info "Setting up Husky Git hooks..."
    
    # Initialize git if not already present (needed for Husky)
    if [ ! -d ".git" ]; then
        print_info "Initializing Git repository (required for Husky)..."
        git init
    fi
    
    npx husky init
    # Ensure git hooks path is set correctly
    git config core.hooksPath .husky
    print_success "Husky initialized!"
}

# Setup Git hooks
setup_git_hooks() {
    print_info "Setting up Git hooks..."
    
    # Pre-commit hook
    cat > .husky/pre-commit << 'EOL'
npx lint-staged
EOL
    chmod +x .husky/pre-commit
    
    # Commit-msg hook
    cat > .husky/commit-msg << 'EOL'
npx --no -- commitlint --edit $1
EOL
    chmod +x .husky/commit-msg
    
    print_success "Git hooks configured!"
}

# Export functions
export -f setup_husky setup_git_hooks