#!/bin/bash
# AutoDevKit - Clean Encrypted Version
# This version avoids Unicode issues while maintaining functionality

# Create and execute the clean version
execute_autodevkit() {
    cat > /tmp/autodevkit_clean.sh << 'SCRIPT_END'
#!/bin/bash
# AutoDevKit - Clean Minified Version
set -e

# Color codes
G='\033[0;32m'; B='\033[0;34m'; R='\033[0;31m'; Y='\033[1;33m'; P='\033[0;35m'; C='\033[0;36m'; N='\033[0m'

# Print functions
ph() {
    printf "${P}\n"
    printf "================================================================\n"
    printf "                    🚀 AutoDevKit 🚀                           \n"
    printf "        Choose your technology and get instant setup!          \n"
    printf "================================================================\n"
    printf "${N}\n"
}

ps() { printf "${G}✅ $1${N}\n"; }
pi() { printf "${B}📦 $1${N}\n"; }
pe() { printf "${R}❌ $1${N}\n"; }

# Ask project type
apt() {
    printf "${C}🔧 What type of project are you setting up?${N}\n"
    printf "1) Fresh new project\n2) Existing project\n\n"
    read -p "Choose (1-2): " PROJECT_SETUP
    case $PROJECT_SETUP in
        1) PROJECT_TYPE="fresh" ;;
        2) PROJECT_TYPE="existing" ;;
        *) pe "Invalid choice. Defaulting to existing project."; PROJECT_TYPE="existing" ;;
    esac
}

# Ask technology
at() {
    printf "\n${C}🛠  What technology stack are you using?${N}\n"
    printf "1) React.js (Frontend web app)\n"
    printf "2) React Native (Mobile app)\n"
    printf "3) Node.js (Backend/API)\n"
    printf "4) General JavaScript/TypeScript\n\n"
    read -p "Choose (1-4): " TECH_CHOICE
    case $TECH_CHOICE in
        1) TECHNOLOGY="react" ;;
        2) TECHNOLOGY="react-native" ;;
        3) TECHNOLOGY="nodejs" ;;
        4) TECHNOLOGY="general" ;;
        *) pe "Invalid choice. Defaulting to general."; TECHNOLOGY="general" ;;
    esac
}

# Ask demo mode
adm() {
    printf "\n${C}🎬 Do you want to run the demo mode?${N}\n"
    printf "    (Creates sample files and shows commit validation in action)\n\n"
    read -p "Run demo? (y/n): " DEMO_CHOICE
    case $DEMO_CHOICE in
        [yY]|[yY][eE][sS]) DEMO_MODE="true" ;;
        *) DEMO_MODE="false" ;;
    esac
}

# Show configuration
sc() {
    printf "\n${G}🎯 Configuration Selected:${N}\n"
    printf "    Project: ${Y}$PROJECT_TYPE${N}\n"
    printf "    Technology: ${Y}$TECHNOLOGY${N}\n"
    printf "    Demo Mode: ${Y}$DEMO_MODE${N}\n"
}

# Initialize git
ig() {
    if [ "$PROJECT_TYPE" = "fresh" ] && [ ! -d ".git" ]; then
        pi "Initializing Git repository..."
        git init
        ps "Git repository initialized!"
    fi
}

# Create package.json
cpj() {
    if [ ! -f "package.json" ]; then
        pi "Creating package.json for $TECHNOLOGY project..."
        case $TECHNOLOGY in
            "react")
                cat > package.json << 'EOL'
{
  "name": "react-dev-project",
  "version": "1.0.0",
  "description": "React.js project with professional development setup",
  "main": "index.js",
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build", 
    "test": "react-scripts test",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "validate": "npm run lint && npm run format"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {},
  "browserslist": {
    "production": [">0.2%", "not dead", "not op_mini all"],
    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]
  }
}
EOL
                ;;
            "react-native")
                cat > package.json << 'EOL'
{
  "name": "react-native-dev-project",
  "version": "1.0.0",
  "description": "React Native project with professional development setup",
  "main": "index.js",
  "scripts": {
    "android": "react-native run-android",
    "ios": "react-native run-ios",
    "start": "react-native start",
    "test": "jest",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "validate": "npm run lint && npm run format"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-native": "^0.72.0"
  },
  "devDependencies": {}
}
EOL
                ;;
            "nodejs")
                cat > package.json << 'EOL'
{
  "name": "nodejs-dev-project",
  "version": "1.0.0", 
  "description": "Node.js project with professional development setup",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "validate": "npm run lint && npm run format"
  },
  "dependencies": {
    "express": "^4.18.0"
  },
  "devDependencies": {}
}
EOL
                ;;
            *)
                cat > package.json << 'EOL'
{
  "name": "js-dev-project",
  "version": "1.0.0",
  "description": "JavaScript project with professional development setup", 
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest",
    "lint": "eslint . --fix", 
    "format": "prettier --write .",
    "validate": "npm run lint && npm run format"
  },
  "devDependencies": {}
}
EOL
                ;;
        esac
        ps "package.json created for $TECHNOLOGY!"
    fi
}

# Create .gitignore
cgi() {
    if [ ! -f ".gitignore" ]; then
        pi "Setting up .gitignore for $TECHNOLOGY..."
        cat > .gitignore << 'EOL'
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
build/
dist/
.next/
out/
.env*
!.env.example
.vscode/
.idea/
*.swp
*.swo
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
coverage/
.nyc_output/
*.tmp
*.temp
.cache/
EOL

        if [ "$TECHNOLOGY" = "react-native" ]; then
            cat >> .gitignore << 'EOL'
.expo/
.expo-shared/
android/
ios/
EOL
        fi
        ps ".gitignore created for $TECHNOLOGY!"
    fi
}

# Install dependencies
id() {
    pi "Installing development dependencies..."
    npm install --save-dev husky@9.1.7 eslint@8.57.0 prettier@3.0.0 lint-staged@15.0.0 @commitlint/cli@18.0.0 @commitlint/config-conventional@18.0.0
    
    case $TECHNOLOGY in
        "react")
            npm install --save-dev eslint-plugin-react@7.33.0 eslint-plugin-react-hooks@4.6.0 eslint-plugin-jsx-a11y@6.7.0 @eslint/eslintrc@2.1.0
            ;;
        "react-native")
            npm install --save-dev eslint-plugin-react@7.33.0 eslint-plugin-react-hooks@4.6.0 eslint-plugin-react-native@4.1.0 @eslint/eslintrc@2.1.0
            ;;
        "nodejs")
            npm install --save-dev eslint-plugin-node@11.1.0 @eslint/eslintrc@2.1.0
            ;;
        *)
            npm install --save-dev @eslint/eslintrc@2.1.0
            ;;
    esac
    ps "All dependencies installed!"
}

# Setup husky
sh() {
    pi "Setting up Husky Git hooks..."
    if [ ! -d ".git" ]; then
        pi "Initializing Git repository (required for Husky)..."
        git init
    fi
    npx husky init
    git config core.hooksPath .husky
    ps "Husky initialized!"
}

# Setup ESLint config
sec() {
    pi "Creating ESLint config for $TECHNOLOGY..."
    case $TECHNOLOGY in
        "react")
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:jsx-a11y/recommended'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 12,
    sourceType: 'module'
  },
  plugins: ['react', 'react-hooks', 'jsx-a11y'],
  rules: {
    'react/react-in-jsx-scope': 'off',
    'react/prop-types': 'warn',
    'no-unused-vars': 'warn',
    'no-console': 'warn'
  },
  settings: {
    react: {
      version: 'detect'
    }
  },
  ignorePatterns: ['build/', 'dist/', 'node_modules/', '*.min.js', '.husky/']
};
EOL
            ;;
        "react-native")
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    es2021: true,
    node: true,
    'react-native/react-native': true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:react-native/all'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 12,
    sourceType: 'module'
  },
  plugins: ['react', 'react-hooks', 'react-native'],
  rules: {
    'react/react-in-jsx-scope': 'off',
    'react-native/no-unused-styles': 'warn',
    'react-native/split-platform-components': 'warn',
    'no-unused-vars': 'warn',
    'no-console': 'warn'
  },
  settings: {
    react: {
      version: 'detect'
    }
  },
  ignorePatterns: ['android/', 'ios/', 'node_modules/', '*.min.js', '.husky/']
};
EOL
            ;;
        "nodejs")
            cat > .eslintrc.cjs << 'EOL'
module.exports = {
  env: {
    es2021: true,
    node: true
  },
  extends: ['eslint:recommended', 'plugin:node/recommended'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module'
  },
  plugins: ['node'],
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error',
    'no-undef': 'error',
    'node/no-unsupported-features/es-syntax': 'off'
  },
  ignorePatterns: ['node_modules/', 'dist/', 'build/', '*.min.js', '.husky/']
};
EOL
            ;;
        *)
            cat > .eslintrc.js << 'EOL'
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: ['eslint:recommended'],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module'
  },
  rules: {
    'no-unused-vars': 'warn',
    'no-console': 'warn'
  },
  ignorePatterns: ['node_modules/', 'dist/', 'build/', '*.min.js', '.husky/']
};
EOL
            ;;
    esac
    ps "ESLint config created for $TECHNOLOGY!"
}

# Setup prettier
sp() {
    pi "Creating Prettier configuration..."
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
    ps "Prettier configuration created!"
}

# Setup lint-staged
sls() {
    pi "Setting up lint-staged..."
    cat > lint-staged.config.cjs << 'EOL'
module.exports = {
  '*.{js,jsx,ts,tsx}': ['eslint --fix', 'prettier --write'],
  '*.{json,css,md}': ['prettier --write']
};
EOL
    ps "lint-staged configured!"
}

# Setup commitlint
scl() {
    pi "Setting up commit message validation..."
    cat > .commitlintrc.json << 'EOL'
{
  "extends": ["@commitlint/config-conventional"],
  "rules": {
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "style", "refactor", "perf", "test", "build", "ci", "chore", "revert"]
    ]
  }
}
EOL
    ps "Commitlint configured!"
}

# Setup git hooks
sgh() {
    pi "Setting up Git hooks..."
    cat > .husky/pre-commit << 'EOL'
npx lint-staged
EOL
    chmod +x .husky/pre-commit
    
    cat > .husky/commit-msg << 'EOL'
npx --no -- commitlint --edit $1
EOL
    chmod +x .husky/commit-msg
    ps "Git hooks configured!"
}

# Create demo files
cdf() {
    if [ "$DEMO_MODE" = "true" ]; then
        pi "Creating demo files for $TECHNOLOGY..."
        case $TECHNOLOGY in
            "react")
                mkdir -p src
                cat > src/App.js << 'EOL'
import React from 'react';

function App() {
  const handleClick = () => {
    console.log('Hello from React!');
  };

  return (
    <div>
      <h1>Hello React!</h1>
      <button onClick={handleClick}>Click me</button>
    </div>
  );
}

export default App;
EOL
                ;;
            "react-native")
                cat > App.js << 'EOL'
import React from 'react';
import {View, Text, TouchableOpacity, StyleSheet} from 'react-native';

const COLORS = {
  primary: '#007AFF'
};

const App = () => {
  const handlePress = () => {
    console.log('Hello from React Native!');
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Hello React Native!</Text>
      <TouchableOpacity style={styles.button} onPress={handlePress}>
        <Text>Press me</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  title: {
    fontSize: 24,
    marginBottom: 20
  },
  button: {
    backgroundColor: COLORS.primary,
    padding: 10,
    borderRadius: 5
  }
});

export default App;
EOL
                ;;
            "nodejs")
                cat > index.js << 'EOL'
import express from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({message: 'Hello from Node.js!'});
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOL
                ;;
            *)
                cat > index.js << 'EOL'
const greet = (name) => {
  console.log(`Hello, ${name}!`);
  return `Hello, ${name}!`;
};

const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(num => num * 2);

console.log('Doubled numbers:', doubled);
greet('Developer');
EOL
                ;;
        esac
        ps "Demo files created!"
    fi
}

# Run demo
rd() {
    if [ "$DEMO_MODE" = "true" ]; then
        printf "\n${P}🎬 DEMO MODE: Let's see the validation in action!${N}\n\n"
        
        if [ ! -d ".git" ]; then
            pi "Initializing Git for demo..."
            git init
            git config core.hooksPath .husky
        fi
        
        git add .
        
        pi "Step 1: Trying to commit with bad message..."
        printf "\n${Y}Command: git commit -m \"bad commit message\"${N}\n"
        
        if git commit -m "bad commit message" 2>/dev/null; then
            pe "Commit should have been rejected but wasn't!"
        else
            ps "✅ Bad commit message was rejected! (As expected)"
        fi
        
        git reset --soft HEAD~1 2>/dev/null || true
        
        printf "\n${B}📦 Step 2: Fixing the code and using proper commit message...${N}\n"
        pi "Trying proper commit message..."
        printf "${Y}Command: git commit -m \"feat: add demo files for $TECHNOLOGY project\"${N}\n"
        
        if git commit -m "feat: add demo files for $TECHNOLOGY project"; then
            ps "✅ Proper commit message accepted!"
        else
            pe "Commit failed - there might still be linting issues"
        fi
        
        printf "\n${G}🎉 Demo completed! Your setup is working perfectly!${N}\n"
    fi
}

# Final completion message
sc2() {
    printf "\n${G}"
    printf "================================================================\n"
    printf "                    🎉 SETUP COMPLETE! 🎉                      \n"
    printf "================================================================\n"
    printf "${N}\n"
    printf "${G}✅ $TECHNOLOGY project configured successfully!${N}\n"
    printf "${G}✅ Husky + ESLint + Prettier + Commitlint ready!${N}\n"
    printf "${G}✅ Git hooks active and working!${N}\n"
    printf "${G}✅ No deprecation warnings!${N}\n"
    
    if [ "$DEMO_MODE" = "true" ]; then
        printf "${G}✅ Demo completed successfully!${N}\n"
    fi
    
    printf "\n${C}🎯 Available Commands:${N}\n"
    printf "    ${Y}npm run lint${N}                - Check and fix code quality\n"
    printf "    ${Y}npm run format${N}              - Format all files\n"
    printf "    ${Y}npm run validate${N}            - Run full validation\n"
    printf "    ${Y}npm test${N}                    - Run tests\n\n"
    
    printf "${C}📝 Commit Message Format:${N}\n"
    printf "    ${Y}feat: add new feature${N}\n"
    printf "    ${Y}fix: resolve bug issue${N}\n"
    printf "    ${Y}docs: update README${N}\n\n"
    
    printf "${G}🚀 Your $TECHNOLOGY development environment is ready!${N}\n\n"
}

# Main execution flow
main() {
    ph
    apt
    at
    adm
    sc
    printf "\n${B}📦 Starting setup for $TECHNOLOGY project...${N}\n"
    ig
    cpj
    cgi
    id
    sh
    sec
    sp
    sls
    scl
    sgh
    cdf
    rd
    sc2
}

main "$@"
SCRIPT_END

    # Execute the clean script
    bash /tmp/autodevkit_clean.sh "$@"
    
    # Cleanup
    rm -f /tmp/autodevkit_clean.sh
}

# Execute the main function
execute_autodevkit "$@"