#!/bin/bash

# 🛠️ AutoDevKit Development Manager
# Provides easy commands for building, testing, and managing the project
# Usage: ./dev.sh [command]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_info() { printf "${BLUE}📦 $1${NC}\n"; }
print_success() { printf "${GREEN}✅ $1${NC}\n"; }
print_error() { printf "${RED}❌ $1${NC}\n"; }
print_warning() { printf "${YELLOW}⚠️  $1${NC}\n"; }

show_help() {
    printf "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}\n"
    printf "${CYAN}║              🛠️ AutoDevKit Dev Manager 🛠️               ║${NC}\n"
    printf "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}\n\n"
    
    printf "${YELLOW}Available commands:${NC}\n\n"
    
    printf "${GREEN}Build Commands:${NC}\n"
    printf "  ${CYAN}build${NC}        - Build single-file setup_project.sh\n"
    printf "  ${CYAN}watch${NC}        - Watch for changes and auto-rebuild\n"
    printf "  ${CYAN}clean${NC}        - Clean generated files\n\n"
    
    printf "${GREEN}Test Commands:${NC}\n"
    printf "  ${CYAN}test${NC}         - Test the built setup_project.sh\n"
    printf "  ${CYAN}test-modules${NC} - Test individual modules\n"
    printf "  ${CYAN}validate${NC}     - Validate all shell scripts\n\n"
    
    printf "${GREEN}Distribution Commands:${NC}\n"
    printf "  ${CYAN}package${NC}      - Create distribution packages\n"
    printf "  ${CYAN}release${NC}      - Prepare for release (build + package + commit)\n"
    printf "  ${CYAN}deploy${NC}       - Deploy to GitHub (push changes)\n\n"
    
    printf "${GREEN}Development Commands:${NC}\n"
    printf "  ${CYAN}dev${NC}          - Start development mode (watch + test)\n"
    printf "  ${CYAN}format${NC}       - Format all shell scripts\n"
    printf "  ${CYAN}lint${NC}         - Lint shell scripts with shellcheck\n\n"
    
    printf "${GREEN}Utility Commands:${NC}\n"
    printf "  ${CYAN}status${NC}       - Show project status\n"
    printf "  ${CYAN}size${NC}         - Show file sizes\n"
    printf "  ${CYAN}help${NC}         - Show this help\n\n"
    
    printf "${YELLOW}Examples:${NC}\n"
    printf "  ./dev.sh build          # Build single file\n"
    printf "  ./dev.sh watch          # Start auto-rebuild\n"
    printf "  ./dev.sh release        # Full release process\n\n"
}

# Build single file
cmd_build() {
    print_info "Building setup_project.sh..."
    chmod +x build.sh
    ./build.sh
    print_success "Build completed!"
}

# Watch for changes
cmd_watch() {
    print_info "Starting watcher..."
    chmod +x watch-build.sh
    ./watch-build.sh
}

# Clean generated files
cmd_clean() {
    print_info "Cleaning generated files..."
    rm -f setup_project.sh
    rm -f *.tar.gz
    print_success "Clean completed!"
}

# Test the built file
cmd_test() {
    if [ ! -f "setup_project.sh" ]; then
        print_warning "setup_project.sh not found. Building first..."
        cmd_build
    fi
    
    print_info "Testing setup_project.sh..."
    
    # Create test directory
    local test_dir="/tmp/autodevkit_test_$$"
    mkdir -p "$test_dir"
    cp setup_project.sh "$test_dir/"
    
    cd "$test_dir"
    
    # Test syntax
    if bash -n setup_project.sh; then
        print_success "Syntax test passed"
    else
        print_error "Syntax test failed"
        cd - >/dev/null
        rm -rf "$test_dir"
        return 1
    fi
    
    # Test function existence
    local functions=(print_header ask_project_type ask_technology main)
    for func in "${functions[@]}"; do
        if grep -q "^${func}()" setup_project.sh; then
            print_success "Function $func found"
        else
            print_error "Function $func missing"
        fi
    done
    
    cd - >/dev/null
    rm -rf "$test_dir"
    print_success "Test completed!"
}

# Test individual modules
cmd_test_modules() {
    print_info "Testing individual modules..."
    
    local modules=(
        "scripts/ui/colors.sh"
        "scripts/ui/print.sh" 
        "scripts/ui/prompts.sh"
        "scripts/config/package.sh"
        "scripts/core/git.sh"
    )
    
    for module in "${modules[@]}"; do
        if [ -f "$module" ]; then
            if bash -n "$module"; then
                print_success "✓ $module"
            else
                print_error "✗ $module"
            fi
        else
            print_warning "? $module (not found)"
        fi
    done
}

# Validate all shell scripts
cmd_validate() {
    print_info "Validating all shell scripts..."
    
    if command -v shellcheck >/dev/null 2>&1; then
        find . -name "*.sh" -not -path "./.*" | while read -r file; do
            if shellcheck "$file"; then
                print_success "✓ $file"
            else
                print_error "✗ $file"
            fi
        done
    else
        print_warning "shellcheck not found. Install with: brew install shellcheck"
        cmd_test_modules
    fi
}

# Create distribution packages
cmd_package() {
    print_info "Creating distribution packages..."
    
    # Ensure we have the built file
    if [ ! -f "setup_project.sh" ]; then
        cmd_build
    fi
    
    # Create timestamp
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    # Single-file package
    cp setup_project.sh "setup_project_${timestamp}.sh"
    print_success "Created: setup_project_${timestamp}.sh"
    
    # Full archive
    tar -czf "autodevkit-full-${timestamp}.tar.gz" \
        setup.sh setup_project.sh build.sh scripts/ examples/ \
        README.md MODULAR_ARCHITECTURE.md LICENSE *.md
    print_success "Created: autodevkit-full-${timestamp}.tar.gz"
    
    # Single-file archive  
    tar -czf "autodevkit-single-${timestamp}.tar.gz" setup_project.sh README.md LICENSE
    print_success "Created: autodevkit-single-${timestamp}.tar.gz"
}

# Full release process
cmd_release() {
    print_info "Starting release process..."
    
    cmd_build
    cmd_test
    cmd_package
    
    print_success "Release process completed!"
    print_info "Files ready for distribution:"
    ls -la setup_project*.sh setup_project*.tar.gz autodevkit*.tar.gz 2>/dev/null || true
}

# Deploy to GitHub
cmd_deploy() {
    print_info "Deploying to GitHub..."
    
    git add .
    git status
    
    echo ""
    printf "${YELLOW}Commit message (or press Enter for auto-message): ${NC}"
    read -r commit_msg
    
    if [ -z "$commit_msg" ]; then
        commit_msg="feat: update setup_project.sh - auto-generated at $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    
    git commit -m "$commit_msg"
    git push origin main
    
    print_success "Deployed to GitHub!"
}

# Development mode
cmd_dev() {
    print_info "Starting development mode..."
    print_info "This will watch for changes and auto-rebuild"
    print_info "Open another terminal to make changes"
    echo ""
    
    cmd_watch
}

# Format shell scripts
cmd_format() {
    print_info "Formatting shell scripts..."
    
    if command -v shfmt >/dev/null 2>&1; then
        find . -name "*.sh" -not -path "./.*" -exec shfmt -w -i 4 {} \;
        print_success "Formatted all shell scripts"
    else
        print_warning "shfmt not found. Install with: brew install shfmt"
        print_info "Manually checking basic formatting..."
        find . -name "*.sh" -not -path "./.*" | while read -r file; do
            if grep -q $'\t' "$file"; then
                print_warning "$file contains tabs (should be spaces)"
            else
                print_success "✓ $file"
            fi
        done
    fi
}

# Lint shell scripts
cmd_lint() {
    print_info "Linting shell scripts..."
    cmd_validate
}

# Show project status
cmd_status() {
    printf "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}\n"
    printf "${CYAN}║                  📊 Project Status 📊                   ║${NC}\n"
    printf "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}\n\n"
    
    # Main files
    printf "${YELLOW}📁 Main Files:${NC}\n"
    [ -f "setup.sh" ] && printf "  ✅ setup.sh (modular)\n" || printf "  ❌ setup.sh (missing)\n"
    [ -f "setup_project.sh" ] && printf "  ✅ setup_project.sh (single-file)\n" || printf "  ❌ setup_project.sh (not built)\n"
    [ -f "build.sh" ] && printf "  ✅ build.sh\n" || printf "  ❌ build.sh (missing)\n"
    
    # Module count
    printf "\n${YELLOW}📦 Modules:${NC}\n"
    printf "  🎨 UI: $(find scripts/ui -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') files\n"
    printf "  ⚙️  Config: $(find scripts/config -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') files\n"
    printf "  🔧 Core: $(find scripts/core -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') files\n"
    printf "  🎬 Demo: $(find scripts/demo -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') files\n"
    
    # Git status
    printf "\n${YELLOW}📝 Git Status:${NC}\n"
    if git status --porcelain | grep -q .; then
        printf "  ⚠️  Uncommitted changes\n"
    else
        printf "  ✅ Clean working directory\n"
    fi
    
    echo ""
}

# Show file sizes
cmd_size() {
    printf "${YELLOW}📏 File Sizes:${NC}\n"
    
    if [ -f "setup.sh" ]; then
        local size=$(wc -c < "setup.sh")
        local size_kb=$((size / 1024))
        printf "  setup.sh (modular): ${size_kb}KB\n"
    fi
    
    if [ -f "setup_project.sh" ]; then
        local size=$(wc -c < "setup_project.sh")
        local size_kb=$((size / 1024))
        printf "  setup_project.sh (single): ${size_kb}KB\n"
    fi
    
    printf "  Total modules: $(find scripts -name "*.sh" -exec wc -c {} + | tail -1 | awk '{print int($1/1024)"KB"}')\n"
}

# Main command dispatcher
main() {
    case "${1:-help}" in
        "build")        cmd_build ;;
        "watch")        cmd_watch ;;
        "clean")        cmd_clean ;;
        "test")         cmd_test ;;
        "test-modules") cmd_test_modules ;;
        "validate")     cmd_validate ;;
        "package")      cmd_package ;;
        "release")      cmd_release ;;
        "deploy")       cmd_deploy ;;
        "dev")          cmd_dev ;;
        "format")       cmd_format ;;
        "lint")         cmd_lint ;;
        "status")       cmd_status ;;
        "size")         cmd_size ;;
        "help"|*)       show_help ;;
    esac
}

main "$@"