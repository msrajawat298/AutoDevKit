# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-04

### Added
- ✨ Interactive setup wizard with technology selection
- 🎨 Automatic code formatting with Prettier
- 🔍 Code quality checks with ESLint
- 📝 Commit message validation with Commitlint  
- 🪝 Git hooks integration with Husky
- 🛠 Technology-specific configurations for:
  - React.js projects
  - React Native projects
  - Node.js projects
  - General JavaScript projects
- 🎬 Demo mode for presentations and learning
- 📁 Smart .gitignore generation based on technology
- ⚡ Pre-configured npm scripts
- 🚫 Zero deprecation warnings
- 📚 Comprehensive documentation

### Technology Support
- **React.js**: JSX support, React hooks linting, Next.js compatibility
- **React Native**: Mobile-specific rules, platform ignores, RN scripts
- **Node.js**: Server-side rules, console.log allowed, nodemon integration
- **General JS**: Universal rules, works with any JavaScript project

### Configuration Files
- `.eslintrc.json` - ESLint configuration (JSON format, no warnings)
- `.prettierrc` - Prettier formatting rules
- `.commitlintrc.json` - Commit message validation rules
- `.lintstagedrc.json` - Pre-commit task configuration
- `.eslintignore` - Files to exclude from linting
- `.gitignore` - Technology-specific git ignores
- `.husky/pre-commit` - Pre-commit validation hook
- `.husky/commit-msg` - Commit message validation hook

### Features
- 🎯 Interactive prompts for setup customization
- 🔄 Fresh project vs existing project detection
- 📦 Automatic dependency installation
- 🎨 Beautiful colored terminal output
- ⚡ Fast, targeted linting (only staged files)
- 🛡️ Professional commit message formatting
- 🎬 Built-in demo mode for presentations

### Demo Mode
- Creates sample files with intentional linting issues
- Demonstrates bad commit rejection
- Shows automatic code formatting
- Displays successful commit with proper message
- Perfect for YouTube tutorials and presentations

### npm Scripts Added
- `npm run lint` - Check code quality
- `npm run lint:fix` - Fix linting issues automatically
- `npm run format` - Format all files with Prettier
- `npm run format:check` - Check if files are properly formatted
- `npm run validate` - Run complete validation (lint + format check)

### Supported Commit Types
- `feat` - New features
- `fix` - Bug fixes
- `docs` - Documentation changes
- `style` - Code style changes (formatting, etc.)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Build/maintenance tasks
- `perf` - Performance improvements
- `ci` - CI configuration changes
- `build` - Build system changes
- `revert` - Reverting changes

### Documentation
- Comprehensive README with usage examples
- Contributing guidelines for developers
- Detailed explanation of each generated file
- Troubleshooting guide
- Customization instructions
- File modification guidelines

## [Unreleased]

### Planned
- TypeScript support
- Vue.js integration
- Svelte framework support
- Custom rule templates
- VSCode extension integration
- CI/CD pipeline examples