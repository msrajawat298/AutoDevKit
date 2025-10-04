#!/bin/bash

# 📦 Dependency management for AutoDevKit
# Handles npm package installation based on technology

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Install development dependencies
install_dependencies() {
    print_info "Installing development dependencies..."
    
    # Base dependencies
    npm install --save-dev \
        husky@^9.1.7 \
        eslint@^8.57.0 \
        prettier@^3.0.0 \
        lint-staged@^15.0.0 \
        @commitlint/cli@^18.0.0 \
        @commitlint/config-conventional@^18.0.0
    
    # Technology-specific dependencies
    case $TECHNOLOGY in
        "react")
            npm install --save-dev \
                eslint-plugin-react@^7.33.0 \
                eslint-plugin-react-hooks@^4.6.0 \
                eslint-plugin-jsx-a11y@^6.7.0 \
                @eslint/eslintrc@^2.1.0
            ;;
        "react-native")
            npm install --save-dev \
                eslint-plugin-react@^7.33.0 \
                eslint-plugin-react-hooks@^4.6.0 \
                eslint-plugin-react-native@^4.1.0 \
                @eslint/eslintrc@^2.1.0
            ;;
        "nodejs")
            npm install --save-dev \
                eslint-plugin-node@^11.1.0 \
                @eslint/eslintrc@^2.1.0
            ;;
        *)
            npm install --save-dev @eslint/eslintrc@^2.1.0
            ;;
    esac
    
    print_success "All dependencies installed!"
}

# Export functions
export -f install_dependencies