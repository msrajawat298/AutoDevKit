#!/bin/bash

# 👁️ Auto-build Watcher for AutoDevKit
# Automatically rebuilds setup_project.sh when any module file changes
# Usage: ./watch-build.sh

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_info() {
    printf "${BLUE}📦 $1${NC}\n"
}

print_success() {
    printf "${GREEN}✅ $1${NC}\n"
}

print_watch() {
    printf "${CYAN}👁️  $1${NC}\n"
}

print_header() {
    printf "${YELLOW}\n"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║              👁️ AutoDevKit Watcher 👁️                   ║\n"
    printf "║                                                          ║\n"
    printf "║     Watching for changes in modular components...        ║\n"
    printf "║                                                          ║\n"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "${NC}\n"
}

# Check if fswatch is available
check_fswatch() {
    if ! command -v fswatch >/dev/null 2>&1; then
        print_info "fswatch not found. Installing via Homebrew..."
        if command -v brew >/dev/null 2>&1; then
            brew install fswatch
        else
            printf "${YELLOW}Please install fswatch manually:${NC}\n"
            printf "  macOS: brew install fswatch\n"
            printf "  Linux: sudo apt-get install fswatch\n"
            exit 1
        fi
    fi
}

# Manual watch (fallback)
manual_watch() {
    print_info "Using manual polling (checking every 3 seconds)..."
    print_info "Press Ctrl+C to stop watching"
    echo ""
    
    local last_hash=""
    
    while true; do
        # Calculate hash of all module files
        local current_hash=$(find scripts/ -name "*.sh" -exec shasum {} \; 2>/dev/null | shasum | cut -d' ' -f1)
        
        if [ "$current_hash" != "$last_hash" ] && [ -n "$last_hash" ]; then
            print_watch "Changes detected! Rebuilding..."
            ./build.sh
            print_success "Auto-rebuild completed at $(date '+%H:%M:%S')"
            echo ""
        fi
        
        last_hash="$current_hash"
        sleep 3
    done
}

# fswatch-based watcher
fswatch_watcher() {
    print_info "Using fswatch for real-time monitoring..."
    print_info "Press Ctrl+C to stop watching"
    echo ""
    
    # Initial build
    ./build.sh
    print_success "Initial build completed"
    echo ""
    
    # Watch for changes
    fswatch -o scripts/ | while read -r num; do
        print_watch "Changes detected! Rebuilding..."
        ./build.sh
        print_success "Auto-rebuild completed at $(date '+%H:%M:%S')"
        echo ""
    done
}

# Simple polling watcher (cross-platform)
simple_watch() {
    print_info "Using simple file modification time polling..."
    print_info "Press Ctrl+C to stop watching"
    echo ""
    
    # Get initial modification times
    local last_mod=$(find scripts/ -name "*.sh" -exec stat -f "%m" {} \; 2>/dev/null | sort -nr | head -1)
    
    while true; do
        sleep 2
        local current_mod=$(find scripts/ -name "*.sh" -exec stat -f "%m" {} \; 2>/dev/null | sort -nr | head -1)
        
        if [ "$current_mod" != "$last_mod" ]; then
            print_watch "File modification detected! Rebuilding..."
            ./build.sh
            print_success "Auto-rebuild completed at $(date '+%H:%M:%S')"
            echo ""
            last_mod="$current_mod"
        fi
    done
}

# Main watcher
main() {
    print_header
    
    # Check if we're in the right directory
    if [ ! -f "build.sh" ]; then
        printf "${RED}❌ Please run this script from the AutoDevKit root directory${NC}\n"
        printf "${RED}❌ Required: build.sh not found${NC}\n"
        exit 1
    fi
    
    # Make sure build.sh is executable
    chmod +x build.sh
    
    print_info "Monitoring files in scripts/ directory..."
    print_info "Will automatically rebuild setup_project.sh on changes"
    echo ""
    
    # Try different watching methods
    if command -v fswatch >/dev/null 2>&1; then
        fswatch_watcher
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - try to use stat
        simple_watch
    else
        # Fallback to manual polling
        manual_watch
    fi
}

# Handle Ctrl+C gracefully
trap 'echo -e "\n${GREEN}✅ Watcher stopped. Final build status:${NC}"; ls -la setup_project.sh; exit 0' INT

# Run the watcher
main "$@"