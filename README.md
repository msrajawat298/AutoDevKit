# 🚀 AutoDevKit

**One-click setup for professional JavaScript development workflow**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![Node.js](https://img.shields.io/badge/Node.js-339933?logo=node.js&logoColor=white)](https://nodejs.org/)

## 🎯 **What This Does**

Sets up a professional development environment with **automatic code formatting**, **linting**, and **commit validation** in under 60 seconds!

### ✨ **Features**
- 🎨 **Automatic code formatting** with Prettier
- 🔍 **Code quality checks** with ESLint  
- 📝 **Commit message validation** with Commitlint
- 🪝 **Git hooks** with Husky
- 🎬 **Interactive setup wizard**
- 🛠 **Technology-specific configurations**

## 🚀 **Quick Start**

### **Method 1: One-liner Installation (Recommended)**
```bash
# Download and run installer (downloads all modular components)
curl -fsSL https://raw.githubusercontent.com/msrajawat298/AutoDevKit/main/install.sh | bash

# Then run the setup
cd autodevkit
./setup.sh
```

### **Method 2: Git Clone**
```bash
# Clone the repository
git clone https://github.com/msrajawat298/AutoDevKit.git
cd AutoDevKit

# Run the setup wizard
chmod +x setup.sh
./setup.sh
```

### **Method 3: Download Archive**
```bash
# Download the latest release archive
curl -L -o autodevkit.tar.gz https://github.com/msrajawat298/AutoDevKit/archive/main.tar.gz
tar -xzf autodevkit.tar.gz
cd AutoDevKit-main

# Run setup
chmod +x setup.sh
./setup.sh
```

That's it! Follow the interactive prompts and you're done! 🎉

## 🛠 **Supported Technologies**

| Technology | ESLint Rules | Prettier Config | Git Ignore | npm Scripts |
|------------|-------------|-----------------|-------------|-------------|
| **React.js** | ✅ React/JSX rules | ✅ JSX formatting | ✅ Next.js builds | ✅ Dev server |
| **React Native** | ✅ RN specific | ✅ Mobile formatting | ✅ iOS/Android | ✅ Platform scripts |
| **Node.js** | ✅ Server-side rules | ✅ Backend formatting | ✅ Server ignores | ✅ Nodemon |
| **General JS** | ✅ Universal rules | ✅ Standard format | ✅ Basic ignores | ✅ Standard scripts |

## 📁 **Generated Files Overview**

After running the setup, you'll get these files in your project:

### 🔧 **Configuration Files (Auto-Generated)**
| File | Purpose | Can I Edit? | Description |
|------|---------|-------------|-------------|
| `.eslintrc.json` | Linting rules | ⚠️ **Carefully** | Defines code quality rules |
| `.prettierrc` | Formatting rules | ✅ **Yes** | Code formatting preferences |
| `.commitlintrc.json` | Commit validation | ⚠️ **Carefully** | Commit message standards |
| `.lintstagedrc.json` | Pre-commit tasks | ⚠️ **Carefully** | What runs before commits |
| `.eslintignore` | Files to skip linting | ✅ **Yes** | Add files to ignore |

### 🪝 **Git Hooks (Auto-Generated)**
| File | Purpose | Can I Edit? | Description |
|------|---------|-------------|-------------|
| `.husky/pre-commit` | Before commit validation | ❌ **No** | Runs linting/formatting |
| `.husky/commit-msg` | Commit message check | ❌ **No** | Validates commit format |

### 📦 **Project Files (Auto-Generated)**
| File | Purpose | Can I Edit? | Description |
|------|---------|-------------|-------------|
| `.gitignore` | Git ignore rules | ✅ **Yes** | Add more files to ignore |
| `package.json` | Project dependencies | ✅ **Yes** | Add your own dependencies |

## 🎨 **Customization Guide**

### ✅ **Safe to Modify**

#### **1. Prettier Configuration (`.prettierrc`)**
```json
{
  "semi": true,           ← Add/remove semicolons
  "singleQuote": true,    ← Use single or double quotes  
  "tabWidth": 2,          ← Change indentation size
  "printWidth": 80        ← Change line width
}
```

#### **2. ESLint Ignore (`.eslintignore`)**
```
# Add your files/folders to ignore
build/
dist/
*.min.js
```

#### **3. Git Ignore (`.gitignore`)**
```
# Add your project-specific ignores
.env.local
*.log
coverage/
```

### ⚠️ **Modify Carefully**

#### **1. ESLint Rules (`.eslintrc.json`)**
Only modify the `rules` section:
```json
{
  "extends": ["..."],  ← Don't change
  "rules": {
    "no-console": "warn",     ← You can modify these
    "no-unused-vars": "error" ← Add your own rules
  }
}
```

#### **2. Commit Rules (`.commitlintrc.json`)**  
You can add more commit types:
```json
{
  "extends": ["@commitlint/config-conventional"],
  "rules": {
    "type-enum": [2, "always", [
      "feat", "fix", "docs",
      "custom-type"  ← Add your types here
    ]]
  }
}
```

### ❌ **Don't Touch These**

- `.husky/pre-commit` - Auto-generated hook
- `.husky/commit-msg` - Auto-generated hook  
- Core ESLint extends configuration
- Lint-staged file patterns

## 🎬 **Demo Mode**

When you choose "Demo Mode" during setup:

1. ✅ **Creates sample files** with intentional issues
2. ✅ **Shows bad commit being rejected**
3. ✅ **Demonstrates auto-formatting**  
4. ✅ **Shows successful commit**

Perfect for presentations and learning!

## 📝 **Commit Message Format**

After setup, use these commit message formats:

```bash
# ✅ Good commits
git commit -m "feat: add user authentication"
git commit -m "fix: resolve login issue"
git commit -m "docs: update README"
git commit -m "style: format code"
git commit -m "refactor: simplify validation"
git commit -m "test: add unit tests"
git commit -m "chore: update dependencies"

# ❌ Bad commits (will be rejected)
git commit -m "fix stuff"
git commit -m "updated files"  
git commit -m "changes"
```

## 🛡️ **What Happens on Every Commit**

1. **Pre-commit Hook Runs:**
   - 🔍 Lints only staged files
   - 🎨 Formats code automatically
   - 📁 Validates file names
   
2. **Commit Message Hook Runs:**
   - 📝 Validates commit message format
   - ❌ Rejects if format is wrong
   - ✅ Allows if format is correct

3. **Result:**
   - Clean, formatted code
   - Professional commit history
   - Consistent code style across team

## ⚡ **Available npm Scripts**

After setup, use these commands:

```bash
# Code quality
npm run lint           # Check for issues
npm run lint:fix       # Fix issues automatically
npm run format         # Format all files
npm run format:check   # Check formatting
npm run validate       # Full validation

# Development (technology-specific)
npm run dev           # Start development server
npm run build         # Build for production
npm run test          # Run tests
```

## 🔧 **Troubleshooting**

### **Issue: Commit is rejected**
```bash
✖ subject may not be empty [subject-empty]
```
**Solution:** Use proper commit format: `feat: your message`

### **Issue: Linting errors**
```bash  
✖ 'variable' is assigned a value but never used
```
**Solution:** Remove unused variables or add `// eslint-disable-next-line`

### **Issue: Permission denied**
```bash
chmod +x setup.sh
./setup.sh
```

## 🎯 **Why Each File Exists**

### **Configuration Philosophy:**
- **JSON configs** - No CommonJS warnings, better IDE support
- **Separate concerns** - Each tool has its own config file
- **Technology-specific** - Rules tailored to your framework
- **Git hooks** - Automatic validation without manual steps

### **File Dependencies:**
```
setup.sh
├── Creates → .eslintrc.json (linting rules)
├── Creates → .prettierrc (formatting rules) 
├── Creates → .commitlintrc.json (commit rules)
├── Creates → .lintstagedrc.json (pre-commit tasks)
├── Creates → .husky/pre-commit (git hook)
├── Creates → .husky/commit-msg (git hook)
└── Updates → package.json (scripts & deps)
```

## 🚀 **For Maintainers**

### **Adding New Technologies:**
1. Add case in `ask_technology()` function
2. Create technology-specific configs in setup functions
3. Add appropriate dependencies
4. Update this README

### **Modifying Configurations:**
1. Test with sample projects
2. Ensure no breaking changes
3. Update documentation
4. Test demo mode works

## 📄 **License**

MIT License - feel free to use in your projects!

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with different technologies
5. Submit a pull request

## ⭐ **Show Your Support**

If this saved you time, please star the repository and share with other developers!

---

**Made with ❤️ for developers who want professional setups without the hassle!**