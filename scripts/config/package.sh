#!/bin/bash

# ⚙️ Package.json generator for AutoDevKit
# Creates technology-specific package.json files

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Create package.json based on technology
create_package_json() {
    if [ ! -f "package.json" ]; then
        print_info "Creating package.json for $TECHNOLOGY project..."
        
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
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
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
        print_success "package.json created for $TECHNOLOGY!"
    fi
}

# Export functions
export -f create_package_json