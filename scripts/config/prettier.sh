#!/bin/bash

# 💅 Prettier configuration generator for AutoDevKit
# Creates technology-specific Prettier configurations

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Setup Prettier configuration
setup_prettier() {
    print_info "Creating Prettier configuration..."
    
    case $TECHNOLOGY in
        "react"|"react-native")
            cat > .prettierrc << 'EOL'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "jsxSingleQuote": true,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid"
}
EOL
            ;;
        *)
            cat > .prettierrc << 'EOL'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
EOL
            ;;
    esac
    
    print_success "Prettier configuration created!"
}

# Export functions
export -f setup_prettier