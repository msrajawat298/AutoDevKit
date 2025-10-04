#!/bin/bash

# 🗂️ .gitignore generator for AutoDevKit
# Creates technology-specific .gitignore files

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Create .gitignore file
create_gitignore() {
    if [ ! -f ".gitignore" ]; then
        print_info "Setting up .gitignore for $TECHNOLOGY..."
        
        cat > .gitignore << 'EOL'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Production builds
build/
dist/
.next/
out/

# Environment variables
.env*
!.env.example

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Testing
coverage/
.nyc_output/

# Temporary files
*.tmp
*.temp
.cache/
EOL

        if [ "$TECHNOLOGY" = "react-native" ]; then
            cat >> .gitignore << 'EOL'

# React Native specific
.expo/
.expo-shared/
android/
ios/
EOL
        fi

        print_success ".gitignore created for $TECHNOLOGY!"
    fi
}

# Export functions
export -f create_gitignore