# Contributing to AutoDevKit

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## 🚀 **Quick Start for Contributors**

1. Fork the repository
2. Clone your fork: `git clone <your-fork-url>`
3. Create a feature branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Test thoroughly
6. Submit a pull request

## 🛠 **Development Setup**

```bash
# Clone the repository
git clone <repo-url>
cd dev-setup-wizard

# Test the script
./setup.sh
```

## 📋 **Code Structure**

### **Main Script (`setup.sh`)**
```bash
setup.sh
├── Interactive prompts      # User selection functions
├── Technology detection     # Framework-specific logic
├── Configuration generators # File creation functions
├── Git hooks setup         # Husky integration
└── Demo mode              # Demonstration features
```

### **Key Functions:**
- `ask_project_type()` - Fresh vs existing project
- `ask_technology()` - Technology selection
- `setup_eslint_config()` - ESLint configuration per tech
- `setup_prettier_config()` - Prettier configuration  
- `create_demo_files()` - Demo mode file generation

## 🎯 **Adding New Technologies**

### **1. Add Technology Option**
In `ask_technology()` function:
```bash
echo "5) Vue.js (Frontend framework)"
# ...
5) TECHNOLOGY="vue" ;;
```

### **2. Create Technology-Specific Configs**

#### **ESLint Configuration:**
In `setup_eslint_config()`:
```bash
"vue")
    cat > eslint.config.js << 'EOF'
const js = require('@eslint/js');

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.{js,vue}'],
    // Vue-specific configuration
  }
];
EOF
    ;;
```

#### **Package.json Template:**
In `setup_package_json()`:
```bash
"vue")
    cat > package.json << EOF
{
  "name": "$(basename $(pwd))",
  "scripts": {
    "dev": "vue-cli-service serve",
    "build": "vue-cli-service build"
  }
}
EOF
    ;;
```

#### **Dependencies:**
In `install_dependencies()`:
```bash
"vue")
    local tech_packages="eslint eslint-plugin-vue prettier"
    ;;
```

### **3. Update Documentation**
- Add to supported technologies table in README
- Update examples and screenshots

## ✅ **Testing Guidelines**

### **Test Each Technology:**
```bash
# Test React setup
echo -e "1\n1\ny" | ./setup.sh

# Test React Native setup  
echo -e "1\n2\ny" | ./setup.sh

# Test Node.js setup
echo -e "1\n3\ny" | ./setup.sh

# Test General JS setup
echo -e "1\n4\ny" | ./setup.sh
```

### **Verify Generated Files:**
- ✅ All config files created correctly
- ✅ No syntax errors in generated files
- ✅ ESLint runs without errors
- ✅ Prettier formats correctly
- ✅ Git hooks work properly
- ✅ Demo mode completes successfully

### **Test Commit Workflow:**
```bash
# Test bad commit (should fail)
git add . && git commit -m "bad message"

# Test good commit (should succeed)  
git commit -m "feat: test commit validation"
```

## 🎨 **Code Style Guidelines**

### **Shell Script Style:**
```bash
# Use consistent indentation (2 spaces)
setup_function() {
  print_info "Setting up..."
  
  case $TECHNOLOGY in
    "react")
      # React-specific code
      ;;
    "vue")
      # Vue-specific code
      ;;
  esac
  
  print_success "Setup complete!"
}

# Use descriptive function names
setup_eslint_config()      # ✅ Good
setup_eslint()             # ❌ Too generic

# Use consistent error handling
command || { print_error "Failed"; exit 1; }
```

### **Configuration File Style:**
```json
// Use consistent JSON formatting
{
  "extends": ["..."],
  "rules": {
    "rule-name": "value"
  }
}
```

## 🐛 **Bug Reports**

### **Include This Information:**
- Operating system and version
- Node.js version
- Technology being set up
- Complete error message
- Steps to reproduce

### **Example Bug Report:**
```
**OS:** macOS 14.0
**Node.js:** v18.17.0  
**Technology:** React Native
**Error:** ESLint config not found

**Steps to reproduce:**
1. Run `./setup.sh`
2. Choose "Fresh project" (1)
3. Choose "React Native" (2)
4. Choose "No demo" (n)
5. Error occurs during ESLint setup

**Expected:** Clean setup without errors
**Actual:** ESLint configuration fails
```

## 💡 **Feature Requests**

### **Good Feature Requests Include:**
- Clear use case and benefit
- Proposed implementation approach
- Compatibility considerations
- Documentation updates needed

### **Example Feature Request:**
```
**Feature:** TypeScript Support

**Use Case:** Many developers use TypeScript and need
proper ESLint + Prettier configuration for .ts/.tsx files

**Proposed Implementation:**
- Add TypeScript as technology option
- Include @typescript-eslint packages
- Update ESLint config for TypeScript rules
- Add tsconfig.json generation

**Compatibility:** Should work with existing React/Node.js options
```

## 🔄 **Pull Request Process**

### **Before Submitting:**
1. ✅ Test with all supported technologies
2. ✅ Update documentation if needed
3. ✅ Ensure no breaking changes
4. ✅ Add appropriate error handling
5. ✅ Test demo mode works

### **PR Description Template:**
```
## What This Changes
Brief description of your changes

## Technology Impact
- [ ] React.js - tested and working
- [ ] React Native - tested and working  
- [ ] Node.js - tested and working
- [ ] General JS - tested and working

## Testing Done
- [ ] Fresh project setup
- [ ] Existing project setup
- [ ] Demo mode
- [ ] Commit validation
- [ ] All npm scripts work

## Documentation
- [ ] README updated
- [ ] Comments added to code
- [ ] Examples provided
```

## 🏗 **Architecture Decisions**

### **Why JSON Configs?**
- No CommonJS module warnings
- Better IDE support and validation
- Cleaner syntax for configuration

### **Why Separate Functions?**
- Technology-specific customization
- Easier testing and maintenance
- Clear separation of concerns

### **Why Interactive Prompts?**
- Better user experience
- Prevents configuration mistakes
- Allows technology-specific optimizations

## 📚 **Resources**

### **Documentation:**
- [ESLint Configuration](https://eslint.org/docs/user-guide/configuring/)
- [Prettier Options](https://prettier.io/docs/en/options.html)
- [Husky Git Hooks](https://typicode.github.io/husky/)
- [Commitlint Rules](https://commitlint.js.org/#/reference-rules)

### **Testing Tools:**
- [Shellcheck](https://www.shellcheck.net/) - Shell script linting
- [JSON Validator](https://jsonlint.com/) - JSON configuration validation

## 🎯 **Roadmap**

### **Planned Features:**
- [ ] TypeScript support
- [ ] Vue.js support  
- [ ] Svelte support
- [ ] Custom rule templates
- [ ] CI/CD integration
- [ ] VSCode extension

### **Long-term Goals:**
- Support for more frameworks
- Integration with popular development tools
- Automated testing for all configurations
- Plugin system for custom extensions

---

**Thank you for contributing to make JavaScript development setup easier for everyone! 🚀**