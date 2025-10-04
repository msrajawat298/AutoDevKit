#!/bin/bash

# 📋 Commitlint configuration generator for AutoDevKit
# Sets up conventional commit message validation

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Setup commit message validation
setup_commitlint() {
    print_info "Setting up commit message validation..."
    
    cat > .commitlintrc.json << 'EOL'
{
  "extends": ["@commitlint/config-conventional"],
  "rules": {
    "type-enum": [
      2,
      "always",
      [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "perf",
        "test",
        "build",
        "ci",
        "chore",
        "revert"
      ]
    ]
  }
}
EOL
    
    print_success "Commitlint configured!"
}

# Export functions
export -f setup_commitlint