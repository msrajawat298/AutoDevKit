# 📁 AutoDevKit Modular Architecture

This document describes the refactored modular structure of AutoDevKit, which improves maintainability, testability, and code organization.

## 🏗️ Directory Structure

```
dev-setup-wizard/
├── setup.sh                    # Main orchestrator script
├── scripts/                    # Modular components directory
│   ├── ui/                     # User interface modules
│   │   ├── colors.sh          # Color definitions and exports
│   │   ├── print.sh           # Print utility functions
│   │   └── prompts.sh         # Interactive user prompts
│   ├── config/                # Configuration generators
│   │   ├── package.sh         # Package.json creation
│   │   ├── gitignore.sh       # .gitignore generation
│   │   ├── eslint.sh          # ESLint configuration
│   │   ├── prettier.sh        # Prettier configuration
│   │   ├── husky.sh           # Husky Git hooks setup
│   │   ├── lint-staged.sh     # lint-staged configuration
│   │   └── commitlint.sh      # Commitlint setup
│   ├── core/                  # Core functionality modules
│   │   ├── git.sh             # Git operations
│   │   └── dependencies.sh    # NPM dependency management
│   └── demo/                  # Demo functionality
│       └── demo.sh            # Demo file creation and execution
├── examples/
└── README.md
```

## 🎯 Module Responsibilities

### UI Modules (`scripts/ui/`)

**colors.sh**
- Defines and exports color variables for consistent formatting
- Provides standardized color codes for output

**print.sh**
- Contains all print utility functions (success, info, warning, error)
- Handles formatted output with colors and icons
- Includes header and completion message functions

**prompts.sh**
- Manages all user interaction and input collection
- Handles project type, technology, and demo mode selection
- Exports user choices as environment variables

### Configuration Modules (`scripts/config/`)

Each configuration module handles a specific tool setup:

- **package.sh**: Creates technology-specific package.json files
- **gitignore.sh**: Generates appropriate .gitignore files
- **eslint.sh**: Creates ESLint configurations for different technologies
- **prettier.sh**: Sets up Prettier formatting rules
- **husky.sh**: Initializes Husky and configures Git hooks
- **lint-staged.sh**: Configures pre-commit linting and formatting
- **commitlint.sh**: Sets up conventional commit message validation

### Core Modules (`scripts/core/`)

**git.sh**
- Handles Git repository initialization
- Manages basic Git operations

**dependencies.sh**
- Manages NPM package installation
- Handles technology-specific dependency selection

### Demo Module (`scripts/demo/`)

**demo.sh**
- Creates sample files for each technology
- Runs interactive demonstration of validation features

## 🔄 How It Works

### 1. Module Loading
The main `setup.sh` script sources all modules at startup:
```bash
source "${SCRIPT_DIR}/scripts/ui/colors.sh"
source "${SCRIPT_DIR}/scripts/ui/print.sh"
# ... other modules
```

### 2. Function Export
Each module exports its functions for use by other modules:
```bash
export -f function_name
```

### 3. Orchestration
The main script orchestrates the setup process in phases:
1. **User Interaction**: Collect preferences
2. **Core Setup**: Initialize Git, create package.json, etc.
3. **Tool Configuration**: Set up linting, formatting, hooks
4. **Demo and Completion**: Run demo if requested, show completion

## ✅ Benefits of Modular Design

### Maintainability
- **Single Responsibility**: Each module has one clear purpose
- **Easy Updates**: Modify specific tools without affecting others
- **Clear Structure**: Logical organization makes code easy to navigate

### Testability
- **Isolated Testing**: Test individual modules independently
- **Mock Dependencies**: Easy to mock imports for unit testing
- **Focused Debugging**: Issues can be isolated to specific modules

### Reusability
- **Selective Import**: Use only needed modules in other scripts
- **Function Export**: Functions available for external scripts
- **Composable**: Mix and match modules for different use cases

### Extensibility
- **New Technologies**: Add support by creating new config modules
- **Additional Tools**: Extend with new configuration generators
- **Custom Workflows**: Create alternative orchestration scripts

## 🛠️ Usage

### Standard Usage
```bash
./setup.sh
```

### Import Individual Modules
```bash
source scripts/ui/print.sh
print_success "Custom message"
```

### Extend Functionality
Create new modules following the same pattern:
```bash
# scripts/config/new-tool.sh
#!/bin/bash
setup_new_tool() {
    print_info "Setting up new tool..."
    # configuration logic
    print_success "New tool configured!"
}
export -f setup_new_tool
```

## 📝 Development Guidelines

### Adding New Modules
1. Create module in appropriate directory (`ui/`, `config/`, `core/`, `demo/`)
2. Include proper shebang and description header
3. Source print functions if needed: `source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"`
4. Export all public functions
5. Add source statement to main `setup.sh`

### Module Standards
- Use descriptive function names
- Include error handling where appropriate
- Follow existing code style and formatting
- Add comments for complex logic
- Test modules independently when possible

This modular architecture makes AutoDevKit more maintainable, testable, and extensible while preserving all existing functionality.