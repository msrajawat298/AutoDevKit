#!/bin/bash

# 🔧 Build Script for AutoDevKit
# Combines all modular components into a single setup_project.sh file
# Usage: ./build.sh

set -e

# Colors for build output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    printf "${BLUE}📦 $1${NC}\n"
}

print_success() {
    printf "${GREEN}✅ $1${NC}\n"
}

print_error() {
    printf "${RED}❌ $1${NC}\n"
}

print_header() {
    printf "${YELLOW}\n"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║              🔧 AutoDevKit Builder 🔧                    ║\n"
    printf "║                                                          ║\n"
    printf "║        Building single-file setup_project.sh             ║\n"
    printf "║                                                          ║\n"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "${NC}\n"
}

# Function to extract function definitions from a file
extract_functions() {
    local file="$1"
    local temp_file="/tmp/extract_functions_$$"
    
    # Skip shebang, comments at start, and source statements
    # Extract only function definitions and their bodies
    awk '
    BEGIN { in_function = 0; brace_count = 0 }
    
    # Skip shebang and initial comments
    /^#!/ { next }
    /^# [^a-zA-Z]/ && !in_function { next }
    /^$/ && !in_function { next }
    
    # Skip source statements
    /^source / { next }
    /^if \[ -z "\$GREEN" \]; then/,/^fi$/ { next }
    
    # Skip export statements at end
    /^export / { next }
    
    # Function definition start
    /^[a-zA-Z_][a-zA-Z0-9_]*\(\) \{/ {
        in_function = 1
        brace_count = 1
        print $0
        next
    }
    
    # Inside function - count braces
    in_function {
        # Count opening braces
        gsub(/\{/, "{", brace_temp)
        brace_count += split(brace_temp, arr, "{") - 1
        
        # Count closing braces
        gsub(/\}/, "}", brace_temp)
        brace_count -= split(brace_temp, arr, "}") - 1
        
        print $0
        
        # Function end
        if (brace_count == 0) {
            in_function = 0
            print ""
        }
    }
    ' "$file" > "$temp_file"
    
    cat "$temp_file"
    rm -f "$temp_file"
}

# Build the combined setup_project.sh
build_setup_project() {
    local output_file="setup_project.sh"
    
    print_info "Building $output_file..."
    
    # Start with the header
    cat > "$output_file" << 'EOF'
#!/bin/bash

# 🚀 AutoDevKit - Single-file Professional Development Setup
# This file is auto-generated from modular components
# 
# Supports: React.js, React Native, Node.js, and general projects
# Features: Interactive setup, demo mode, auto-configuration
# 
# Usage: curl -fsSL <url>/setup_project.sh | bash
#   OR:  chmod +x setup_project.sh && ./setup_project.sh
#
# Generated on: GENERATION_DATE
# Source: https://github.com/msrajawat298/AutoDevKit

set -e

EOF

    # Add generation timestamp
    sed -i '' "s/GENERATION_DATE/$(date '+%Y-%m-%d %H:%M:%S %Z')/" "$output_file"

    # Add colors (inline)
    cat >> "$output_file" << 'EOF'
# ═══════════════════════════════════════════════════════════════
# 🎨 COLOR DEFINITIONS
# ═══════════════════════════════════════════════════════════════

# Color codes for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

EOF

    # Extract and add UI functions
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "# 🖨️ UI FUNCTIONS" >> "$output_file"
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "" >> "$output_file"
    
    extract_functions "scripts/ui/print.sh" >> "$output_file"
    extract_functions "scripts/ui/prompts.sh" >> "$output_file"

    # Extract and add core functions
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "# 🔧 CORE FUNCTIONS" >> "$output_file"
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "" >> "$output_file"
    
    extract_functions "scripts/core/git.sh" >> "$output_file"
    extract_functions "scripts/core/dependencies.sh" >> "$output_file"

    # Extract and add configuration functions
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "# ⚙️ CONFIGURATION FUNCTIONS" >> "$output_file"
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "" >> "$output_file"
    
    extract_functions "scripts/config/package.sh" >> "$output_file"
    extract_functions "scripts/config/gitignore.sh" >> "$output_file"
    extract_functions "scripts/config/eslint.sh" >> "$output_file"
    extract_functions "scripts/config/prettier.sh" >> "$output_file"
    extract_functions "scripts/config/husky.sh" >> "$output_file"
    extract_functions "scripts/config/lint-staged.sh" >> "$output_file"
    extract_functions "scripts/config/commitlint.sh" >> "$output_file"

    # Extract and add demo functions
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "# 🎬 DEMO FUNCTIONS" >> "$output_file"
    echo "# ═══════════════════════════════════════════════════════════════" >> "$output_file"
    echo "" >> "$output_file"
    
    extract_functions "scripts/demo/demo.sh" >> "$output_file"

    # Add main execution logic
    cat >> "$output_file" << 'EOF'
# ═══════════════════════════════════════════════════════════════
# 🚀 MAIN EXECUTION
# ═══════════════════════════════════════════════════════════════

# Main execution orchestrator
main() {
    # Phase 1: User interaction and configuration
    print_header
    ask_project_type
    ask_technology  
    ask_demo_mode
    show_config
    
    printf "\n${BLUE}📦 Starting setup for $TECHNOLOGY project...${NC}\n"
    
    # Phase 2: Core setup
    init_git
    create_package_json
    create_gitignore
    install_dependencies
    
    # Phase 3: Tool configuration
    setup_husky
    setup_eslint_config
    setup_prettier
    setup_lint_staged
    setup_commitlint
    setup_git_hooks
    
    # Phase 4: Demo and completion
    create_demo_files
    run_demo
    show_completion
}

# Run the script only if executed directly (not sourced)
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
EOF

    # Make the file executable
    chmod +x "$output_file"
    
    print_success "$output_file built successfully!"
}

# Validate the built file
validate_build() {
    local output_file="setup_project.sh"
    
    print_info "Validating $output_file..."
    
    # Check syntax
    if bash -n "$output_file"; then
        print_success "Syntax validation passed"
    else
        print_error "Syntax validation failed"
        return 1
    fi
    
    # Check for required functions
    local required_functions=(
        "print_header"
        "ask_project_type"
        "ask_technology"
        "create_package_json"
        "setup_eslint_config"
        "main"
    )
    
    for func in "${required_functions[@]}"; do
        if grep -q "^${func}()" "$output_file"; then
            print_success "Function $func found"
        else
            print_error "Function $func missing"
            return 1
        fi
    done
    
    # Get file size
    local size=$(wc -c < "$output_file")
    local size_kb=$((size / 1024))
    
    print_success "File size: ${size_kb}KB"
    print_success "Validation completed successfully!"
}

# Generate file info
generate_info() {
    local output_file="setup_project.sh"
    
    echo ""
    printf "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}\n"
    printf "${GREEN}║                    🎉 BUILD COMPLETE! 🎉                ║${NC}\n"
    printf "${GREEN}║                                                          ║${NC}\n"
    printf "${GREEN}║  Single-file setup_project.sh is ready for sharing!     ║${NC}\n"
    printf "${GREEN}║                                                          ║${NC}\n"
    printf "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}\n"
    
    printf "\n${BLUE}📁 Generated file: ${YELLOW}$output_file${NC}\n"
    local size_kb=$(($(wc -c < "$output_file") / 1024))
    printf "${BLUE}📏 File size: ${YELLOW}${size_kb}KB${NC}\n"
    printf "${BLUE}🔧 Functions: ${YELLOW}$(grep -c '^[a-zA-Z_][a-zA-Z0-9_]*()' "$output_file")${NC}\n"
    printf "${BLUE}📝 Lines: ${YELLOW}$(wc -l < "$output_file")${NC}\n"
    
    printf "\n${CYAN}🚀 Usage:${NC}\n"
    printf "   ${YELLOW}# Local usage:${NC}\n"
    printf "   ${YELLOW}./$output_file${NC}\n"
    printf "\n   ${YELLOW}# Remote usage:${NC}\n"
    printf "   ${YELLOW}curl -fsSL <your-url>/$output_file | bash${NC}\n"
    
    printf "\n${CYAN}📤 Share this file:${NC}\n"
    printf "   - Upload to GitHub/GitLab raw URL\n"
    printf "   - Host on your server\n"
    printf "   - Share via email/Slack\n"
    printf "   - No dependencies needed!\n\n"
}

# Main build process
main() {
    print_header
    
    # Check if we're in the right directory
    if [ ! -f "scripts/ui/colors.sh" ]; then
        print_error "Please run this script from the AutoDevKit root directory"
        print_error "Required: scripts/ui/colors.sh not found"
        exit 1
    fi
    
    build_setup_project
    validate_build
    generate_info
}

# Run the build
main "$@"