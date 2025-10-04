#!/bin/bash

# 💬 Interactive prompt functions for AutoDevKit
# Handles user input for project configuration

# Source colors and print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

# Ask user what type of project they're setting up
ask_project_type() {
    printf "${CYAN}🤔 What type of project are you setting up?${NC}\n"
    printf "1) Fresh new project\n"
    printf "2) Existing project\n"
    printf "\n"
    read -p "Choose (1-2): " PROJECT_SETUP
    
    case $PROJECT_SETUP in
        1) PROJECT_TYPE="fresh" ;;
        2) PROJECT_TYPE="existing" ;;
        *) 
            printf "${RED}❌ Invalid choice. Defaulting to existing project.${NC}\n"
            PROJECT_TYPE="existing"
            ;;
    esac
    
    export PROJECT_TYPE
}

# Ask user about technology stack
ask_technology() {
    printf "\n${CYAN}🛠  What technology stack are you using?${NC}\n"
    printf "1) React.js (Frontend web app)\n"
    printf "2) React Native (Mobile app)\n"  
    printf "3) Node.js (Backend/API)\n"
    printf "4) General JavaScript/TypeScript\n"
    printf "\n"
    read -p "Choose (1-4): " TECH_CHOICE
    
    case $TECH_CHOICE in
        1) TECHNOLOGY="react" ;;
        2) TECHNOLOGY="react-native" ;;
        3) TECHNOLOGY="nodejs" ;;
        4) TECHNOLOGY="general" ;;
        *) 
            printf "${RED}❌ Invalid choice. Defaulting to general.${NC}\n"
            TECHNOLOGY="general"
            ;;
    esac
    
    export TECHNOLOGY
}

# Ask user about demo mode
ask_demo_mode() {
    printf "\n${CYAN}🎬 Do you want to run the demo mode?${NC}\n"
    printf "   (Creates sample files and shows commit validation in action)\n"
    printf "\n"
    read -p "Run demo? (y/n): " DEMO_CHOICE
    
    case $DEMO_CHOICE in
        [yY]|[yY][eE][sS]) DEMO_MODE="true" ;;
        *) DEMO_MODE="false" ;;
    esac
    
    export DEMO_MODE
}

# Export functions for use in other scripts
export -f ask_project_type ask_technology ask_demo_mode