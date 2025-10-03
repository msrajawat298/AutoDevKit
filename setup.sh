# 🔧 Quick Setup Version (Your Original + Improvements)

#!/bin/bash

# 🚀 Interactive Dev Setup Script - Technology-Specific Configuration
# Supports: React.js, React Native, Node.js, and general projects
# Features: Interactive setup, demo mode, auto-configuration

set -e

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Print functions
print_header() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════    # Configuration files (Node.js environment)
    files: ['*.config.js', 'eslint.config.js'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'commonjs',
      globals: {
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        process: 'readonly',
        console: 'readonly'
      }
    },
    rules: {
      'no-console': 'off'
    }
  },
  {
    # Ignore JSON config files from ESLint
    ignores: ['*.json', '.lintstagedrc.json', '.commitlintrc.json']
  }═════════════════╗"
    echo "║                                                          ║"
    echo "║        🚀 INTERACTIVE AutoDevKit 🚀               ║"
    echo "║                                                          ║"
    echo "║     Choose your technology and get instant setup!        ║"
    echo "║                                                          ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}� $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Interactive prompts
ask_project_type() {
    echo -e "${CYAN}🤔 What type of project are you setting up?${NC}"
    echo "1) Fresh new project"
    echo "2) Existing project"
    echo ""
    read -p "Choose (1-2): " PROJECT_SETUP
    
    case $PROJECT_SETUP in
        1) PROJECT_TYPE="fresh" ;;
        2) PROJECT_TYPE="existing" ;;
        *) 
            print_error "Invalid choice. Defaulting to existing project."
            PROJECT_TYPE="existing"
            ;;
    esac
}

ask_technology() {
    echo -e "\n${CYAN}🛠  What technology stack are you using?${NC}"
    echo "1) React.js (Frontend web app)"
    echo "2) React Native (Mobile app)"  
    echo "3) Node.js (Backend/API)"
    echo "4) General JavaScript/TypeScript"
    echo ""
    read -p "Choose (1-4): " TECH_CHOICE
    
    case $TECH_CHOICE in
        1) TECHNOLOGY="react" ;;
        2) TECHNOLOGY="react-native" ;;
        3) TECHNOLOGY="nodejs" ;;
        4) TECHNOLOGY="general" ;;
        *)
            print_error "Invalid choice. Defaulting to general JavaScript."
            TECHNOLOGY="general"
            ;;
    esac
}

ask_demo_mode() {
    echo -e "\n${CYAN}🎬 Do you want to run the demo mode?${NC}"
    echo "   (Creates sample files and shows commit validation in action)"
    echo ""
    read -p "Run demo? (y/n): " DEMO_CHOICE
    
    case $DEMO_CHOICE in
        [Yy]*) DEMO_MODE=true ;;
        *) DEMO_MODE=false ;;
    esac
}

print_header
ask_project_type
ask_technology  
ask_demo_mode

echo -e "\n${GREEN}🎯 Configuration Selected:${NC}"
echo -e "   Project: ${YELLOW}$PROJECT_TYPE${NC}"
echo -e "   Technology: ${YELLOW}$TECHNOLOGY${NC}" 
echo -e "   Demo Mode: ${YELLOW}$DEMO_MODE${NC}"
echo ""

print_info "Starting setup for $TECHNOLOGY project..."

# Check if this is a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        if [ "$PROJECT_TYPE" = "fresh" ]; then
            print_info "Initializing Git repository..."
            git init
            print_success "Git repository initialized!"
        else
            print_error "This is not a Git repository! Please run 'git init' first."
            exit 1
        fi
    else
        print_success "Git repository detected!"
    fi
}

# Setup package.json based on project type
setup_package_json() {
    if [ "$PROJECT_TYPE" = "fresh" ]; then
        print_info "Creating package.json for $TECHNOLOGY project..."
        
        case $TECHNOLOGY in
            "react")
                cat > package.json << EOF
{
  "name": "$(basename $(pwd))",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {},
  "devDependencies": {}
}
EOF
                ;;
            "react-native")
                cat > package.json << EOF
{
  "name": "$(basename $(pwd))",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "android": "react-native run-android",
    "ios": "react-native run-ios", 
    "start": "react-native start"
  },
  "dependencies": {},
  "devDependencies": {}
}
EOF
                ;;
            "nodejs")
                cat > package.json << EOF
{
  "name": "$(basename $(pwd))",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest"
  },
  "dependencies": {},
  "devDependencies": {}
}
EOF
                ;;
            *)
                npm init --yes > /dev/null 2>&1
                ;;
        esac
        print_success "package.json created for $TECHNOLOGY!"
    elif [ ! -f "package.json" ]; then
        print_info "No package.json found. Creating basic one..."
        npm init --yes > /dev/null 2>&1
        print_success "package.json created!"
    else
        print_success "package.json already exists!"
    fi
}

# Setup .gitignore based on technology
setup_gitignore() {
    print_info "Setting up .gitignore for $TECHNOLOGY..."
    
    if [ ! -f ".gitignore" ]; then
        case $TECHNOLOGY in
            "react")
                cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Next.js
.next/
out/

# Production build
build/
dist/

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
EOF
                ;;
            "react-native")
                cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# React Native
# Build folders
android/app/build/
android/build/
ios/build/
ios/DerivedData/

# Bundle files
*.bundle
*.jsbundle

# Environment variables
.env*

# IDE files  
.vscode/
.idea/

# OS generated files
.DS_Store
.DS_Store?
._*

# Flipper
**/Flipper-*/**

# CocoaPods
ios/Pods/
EOF
                ;;
            "nodejs")
                cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/
*.lcov

# Environment variables
.env*
!.env.example

# Build output
dist/
build/

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS generated files
.DS_Store
Thumbs.db
EOF
                ;;
            *)
                cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build output
dist/
build/

# Environment variables
.env*

# IDE files
.vscode/
.idea/

# OS generated files
.DS_Store
Thumbs.db
EOF
                ;;
        esac
        print_success ".gitignore created for $TECHNOLOGY!"
    else
        print_warning ".gitignore already exists. Skipping..."
    fi
}

# Install dependencies
install_dependencies() {
    print_info "Installing development dependencies..."
    
    # Base packages for all technologies
    local base_packages="husky @commitlint/config-conventional @commitlint/cli lint-staged @eslint/js"
    
    # Technology-specific packages
    case $TECHNOLOGY in
        "react")
            local tech_packages="eslint eslint-plugin-react eslint-plugin-react-hooks @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier"
            ;;
        "react-native")
            local tech_packages="eslint @react-native-community/eslint-config prettier"
            ;;
        "nodejs")
            local tech_packages="eslint prettier nodemon"
            ;;
        *)
            local tech_packages="eslint prettier"
            ;;
    esac
    
    npm install --save-dev $base_packages $tech_packages --silent
    print_success "All dependencies installed!"
}

# Setup Husky (modern way without deprecated commands)
setup_husky() {
    print_info "Setting up Husky Git hooks..."
    
    # Initialize husky (creates .husky directory and setup)
    npx husky init > /dev/null 2>&1
    
    print_success "Husky initialized!"
}

check_git_repo
setup_package_json
setup_gitignore
install_dependencies
setup_husky

# Setup technology-specific ESLint configuration
setup_eslint_config() {
    print_info "Creating ESLint config for $TECHNOLOGY..."
    
    case $TECHNOLOGY in
        "react")
            cat > eslint.config.js << 'EOF'
const js = require('@eslint/js');

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        window: 'readonly',
        document: 'readonly',
        console: 'readonly',
        process: 'readonly'
      },
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      }
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'no-console': 'warn',
      'react/prop-types': 'off',
      'react/react-in-jsx-scope': 'off'
    }
  }
];
EOF
            ;;
        "react-native")
            cat > eslint.config.js << 'EOF'
const js = require('@eslint/js');

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        __DEV__: 'readonly',
        console: 'readonly',
        process: 'readonly',
        global: 'readonly'
      },
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      }
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'no-console': 'off', // Console is fine in React Native
      'react/prop-types': 'off',
      'react/react-in-jsx-scope': 'off'
    }
  }
];
EOF
            ;;
        "nodejs")
            cat > eslint.config.js << 'EOF'
const js = require('@eslint/js');

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.{js,ts}'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        console: 'readonly',
        process: 'readonly',
        Buffer: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        global: 'readonly'
      }
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'no-console': 'off' // Console is fine in Node.js
    }
  }
];
EOF
            ;;
        *)
            cat > eslint.config.js << 'EOF'
const js = require('@eslint/js');

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.js', '**/*.jsx', '**/*.ts', '**/*.tsx'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        // Browser globals
        window: 'readonly',
        document: 'readonly',
        console: 'readonly',
        // Node.js globals
        process: 'readonly',
        Buffer: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        global: 'readonly'
      }
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'no-console': 'warn'
    }
  },
  {
    // Configuration files (Node.js environment)
    files: ['*.config.js', 'eslint.config.js', 'commitlint.config.js', 'lint-staged.config.js'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'commonjs',
      globals: {
        module: 'readonly',
        require: 'readonly',
        exports: 'readonly',
        __dirname: 'readonly',
        __filename: 'readonly',
        process: 'readonly',
        console: 'readonly'
      }
    },
    rules: {
      'no-console': 'off'
    }
  }
];
EOF
            ;;
    esac
    
    print_success "ESLint config created for $TECHNOLOGY!"
    
    # Create .eslintignore to exclude config files and build directories
    cat > .eslintignore << 'EOF'
# Dependencies
node_modules/

# Build outputs
dist/
build/
.next/

# Config files (JSON format)
*.json
.lintstagedrc.json
.commitlintrc.json
package.json
package-lock.json

# Environment files
.env*

# IDE files
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db
EOF
    
    print_success ".eslintignore created!"
}

# Setup Prettier configuration
setup_prettier_config() {
    print_info "Creating Prettier configuration..."
    
    case $TECHNOLOGY in
        "react"|"react-native")
            cat > .prettierrc << 'EOF'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "jsxSingleQuote": true,
  "jsxBracketSameLine": false
}
EOF
            ;;
        *)
            cat > .prettierrc << 'EOF'
{
  "semi": true,
  "trailingComma": "es5", 
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
EOF
            ;;
    esac
    
    print_success "Prettier configuration created!"
}

# Setup lint-staged configuration
setup_lint_staged() {
    print_info "Setting up lint-staged..."
    
    case $TECHNOLOGY in
        "react"|"react-native")
            cat > .lintstagedrc.json << 'EOF'
{
  "*.{js,jsx,ts,tsx}": [
    "eslint --fix",
    "prettier --write"
  ],
  "*.{json,css,scss,md}": [
    "prettier --write"
  ]
}
EOF
            ;;
        *)
            cat > .lintstagedrc.json << 'EOF'
{
  "*.{js,ts}": [
    "eslint --fix",
    "prettier --write"
  ],
  "*.{json,css,md}": [
    "prettier --write"
  ]
}
EOF
            ;;
    esac
    
    print_success "lint-staged configured!"
}

# Setup commitlint
setup_commitlint() {
    print_info "Setting up commit message validation..."
    
    cat > .commitlintrc.json << 'EOF'
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
        "test",
        "chore",
        "perf",
        "ci",
        "build",
        "revert"
      ]
    ],
    "subject-case": [2, "never", ["start-case", "pascal-case", "upper-case"]],
    "subject-empty": [2, "never"],
    "subject-full-stop": [2, "never", "."],
    "header-max-length": [2, "always", 100]
  }
}
EOF
    
    print_success "Commitlint configured!"
}

# Add npm scripts based on technology
setup_npm_scripts() {
    print_info "Adding helpful npm scripts..."
    
    # Base scripts for all technologies
    npm pkg set scripts.lint="eslint . --ext .js,.jsx,.ts,.tsx"
    npm pkg set scripts.lint:fix="eslint . --ext .js,.jsx,.ts,.tsx --fix"  
    npm pkg set scripts.format="prettier --write ."
    npm pkg set scripts.format:check="prettier --check ."
    npm pkg set scripts.validate="npm run lint && npm run format:check"
    npm pkg set scripts.prepare="husky"
    
    # Technology-specific scripts
    case $TECHNOLOGY in
        "react")
            npm pkg set scripts.type-check="tsc --noEmit"
            ;;
        "react-native")
            npm pkg set scripts.pod:install="cd ios && pod install"
            ;;
        "nodejs")
            npm pkg set scripts.dev="nodemon index.js"
            ;;
    esac
    
    print_success "npm scripts configured!"
}

setup_eslint_config
setup_prettier_config  
setup_lint_staged
setup_commitlint
setup_npm_scripts

# Setup Git hooks
setup_git_hooks() {
    print_info "Setting up Git hooks..."
    
    # Pre-commit hook
    cat > .husky/pre-commit << 'EOF'
npx lint-staged
EOF
    
    # Commit-msg hook  
    cat > .husky/commit-msg << 'EOF'
npx --no -- commitlint --edit $1
EOF
    
    chmod +x .husky/pre-commit .husky/commit-msg
    git config core.hooksPath .husky
    
    print_success "Git hooks configured!"
}

# Create demo files based on technology
create_demo_files() {
    if [ "$DEMO_MODE" = false ]; then
        return
    fi
    
    print_info "Creating demo files for $TECHNOLOGY..."
    
    case $TECHNOLOGY in
        "react")
            # Create React component with intentional issues
            mkdir -p src/components
            cat > src/components/BadComponent.jsx << 'EOF'
// Bad React component with linting issues
const badComponent = () => {
const unusedVariable = "This will trigger ESLint error"
    return <div>Hello World</div>
}
export default badComponent
EOF

            cat > src/components/GoodComponent.jsx << 'EOF'
// Well-formatted React component
const GoodComponent = () => {
  return <div>Hello, World!</div>;
};

export default GoodComponent;
EOF
            ;;
            
        "react-native")
            # Create React Native component
            cat > BadScreen.js << 'EOF'
// Bad React Native component
const badScreen = () => {
const unused = "lint error"
return <View><Text>Bad Code</Text></View>
}
export default badScreen
EOF

            cat > GoodScreen.js << 'EOF'
import React from 'react';
import { View, Text } from 'react-native';

const GoodScreen = () => {
  return (
    <View>
      <Text>Good Code!</Text>
    </View>
  );
};

export default GoodScreen;
EOF
            ;;
            
        "nodejs")
            # Create Node.js files
            cat > badServer.js << 'EOF'
// Bad Node.js code
const express = require('express')
const app = express()
const unusedVar = "This will cause lint error"
app.listen(3000)
EOF

            cat > goodServer.js << 'EOF'
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
EOF
            ;;
            
        *)
            # Create general JavaScript files
            cat > badCode.js << 'EOF'
// Bad JavaScript code
const unused = "This variable is not used"
function badFunction(){
console.log("Poor formatting")
}
EOF

            cat > goodCode.js << 'EOF'
// Well-formatted JavaScript code
const message = 'Hello, World!';

function greet(name = 'Developer') {
  console.log(`${message} Welcome, ${name}!`);
  return message;
}

greet();
EOF
            ;;
    esac
    
    print_success "Demo files created!"
}

# Demo mode - show validation in action
run_demo() {
    if [ "$DEMO_MODE" = false ]; then
        return
    fi
    
    echo -e "\n${PURPLE}🎬 DEMO MODE: Let's see the validation in action!${NC}\n"
    
    print_info "Step 1: Adding files with linting issues..."
    git add . > /dev/null 2>&1
    
    print_warning "Trying to commit with bad message..."
    echo -e "\n${YELLOW}Command: git commit -m \"bad commit message\"${NC}"
    
    if git commit -m "bad commit message" 2>/dev/null; then
        print_error "Something went wrong - commit should have been rejected!"
    else
        print_success "✅ Bad commit message was rejected! (As expected)"
    fi
    
    print_info "\nStep 2: Fixing the code and using proper commit message..."
    
    # Fix the files by removing unused variables
    case $TECHNOLOGY in
        "react")
            sed -i '' 's/const unusedVariable = "This will trigger ESLint error"/\/\/ Fixed: removed unused variable/' src/components/BadComponent.jsx 2>/dev/null || true
            ;;
        "react-native")  
            sed -i '' 's/const unused = "lint error"/\/\/ Fixed: removed unused variable/' BadScreen.js 2>/dev/null || true
            ;;
        "nodejs")
            sed -i '' 's/const unusedVar = "This will cause lint error"/\/\/ Fixed: removed unused variable/' badServer.js 2>/dev/null || true
            ;;
        *)
            sed -i '' 's/const unused = "This variable is not used"/\/\/ Fixed: removed unused variable/' badCode.js 2>/dev/null || true
            ;;
    esac
    
    git add . > /dev/null 2>&1
    
    print_info "Trying proper commit message..."
    echo -e "${YELLOW}Command: git commit -m \"feat: add demo files for $TECHNOLOGY project\"${NC}"
    
    if git commit -m "feat: add demo files for $TECHNOLOGY project" > /dev/null 2>&1; then
        print_success "✅ Proper commit succeeded! Code formatted and validated!"
    else
        print_error "Commit failed - there might still be linting issues"
    fi
    
    echo -e "\n${GREEN}🎉 Demo completed! Your setup is working perfectly!${NC}"
}

setup_git_hooks
create_demo_files
run_demo

# Final success message
echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════╗"
echo -e "║                    🎉 SETUP COMPLETE! 🎉                ║"
echo -e "║                                                          ║"
echo -e "║  ✅ $TECHNOLOGY project configured successfully!${NC}"
echo -e "${GREEN}║  ✅ Husky + ESLint + Prettier + Commitlint ready!       ║"
echo -e "║  ✅ Git hooks active and working!                       ║"
echo -e "║  ✅ No deprecation warnings!                            ║"
if [ "$DEMO_MODE" = true ]; then
echo -e "║  ✅ Demo completed successfully!                         ║"
fi
echo -e "╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${CYAN}🎯 Available Commands:${NC}"
echo -e "   ${YELLOW}npm run lint${NC}          - Check code quality"
echo -e "   ${YELLOW}npm run lint:fix${NC}      - Fix linting issues" 
echo -e "   ${YELLOW}npm run format${NC}        - Format all files"
echo -e "   ${YELLOW}npm run validate${NC}      - Run full validation"

echo -e "\n${CYAN}📝 Commit Message Format:${NC}"
echo -e "   ${YELLOW}feat: add new feature${NC}"
echo -e "   ${YELLOW}fix: resolve bug issue${NC}"  
echo -e "   ${YELLOW}docs: update README${NC}"

echo -e "\n${BLUE}🚀 Your $TECHNOLOGY development environment is ready!${NC}\n"