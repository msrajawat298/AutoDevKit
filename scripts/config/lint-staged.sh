#!/bin/bash

# 🔍 Lint-staged configuration generator for AutoDevKit
# Sets up pre-commit linting and formatting

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Setup lint-staged configuration
setup_lint_staged() {
    print_info "Setting up lint-staged..."
    
    cat > lint-staged.config.cjs << 'EOL'
module.exports = {
  '*.{js,jsx,ts,tsx}': ['eslint --fix', 'prettier --write'],
  '*.{json,css,md}': ['prettier --write'],
};
EOL
    
    print_success "lint-staged configured!"
}

# Export functions
export -f setup_lint_staged