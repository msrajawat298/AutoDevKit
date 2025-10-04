#!/bin/bash

# 📝 ESLint configuration generator for AutoDevKit
# Creates technology-specific ESLint configurations

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Setup ESLint configuration based on technology
setup_eslint_config() {
    print_info "Creating ESLint config for $TECHNOLOGY..."
    
    case $TECHNOLOGY in
        "react")
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:jsx-a11y/recommended',
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['react', 'react-hooks', 'jsx-a11y'],
  rules: {
    'react/react-in-jsx-scope': 'off',
    'react/prop-types': 'warn',
    'no-unused-vars': 'warn',
    'no-console': 'warn',
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
  ignorePatterns: ['build/', 'dist/', 'node_modules/', '*.min.js', '.husky/'],
};
EOL
            ;;
        "react-native")
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    es2021: true,
    node: true,
    'react-native/react-native': true,
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:react-native/all',
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['react', 'react-hooks', 'react-native'],
  rules: {
    'react/react-in-jsx-scope': 'off',
    'react-native/no-unused-styles': 'warn',
    'react-native/split-platform-components': 'warn',
    'no-unused-vars': 'warn',
    'no-console': 'warn',
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
  ignorePatterns: ['android/', 'ios/', 'node_modules/', '*.min.js', '.husky/'],
};
EOL
            ;;
        "nodejs")
            cat > .eslintrc.cjs << 'EOL'
module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  extends: ['eslint:recommended', 'plugin:node/recommended'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['node'],
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error',
    'no-undef': 'error',
    'node/no-unsupported-features/es-syntax': 'off',
  },
  ignorePatterns: ['node_modules/', 'dist/', 'build/', '*.min.js', '.husky/'],
};
EOL
            ;;
        *)
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: ['eslint:recommended'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
  },
  rules: {
    'no-unused-vars': 'warn',
    'no-console': 'warn',
  },
  ignorePatterns: ['node_modules/', 'dist/', 'build/', '*.min.js', '.husky/'],
};
EOL
            ;;
    esac
    
    print_success "ESLint config created for $TECHNOLOGY!"
}

# Export functions
export -f setup_eslint_config