#!/bin/bash

# 💬 Interactive prompt functions for AutoDevKit
# Handles user input for project configuration

# Source colors and print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
fi

# Ask user what type of project they're setting up
ask_project_type() {
    printf "${BRIGHT_CYAN}🤔 What type of project are you setting up?${NC}\n\n"
    printf "  ${GREEN}1)${NC} Fresh new project\n"
    printf "  ${BLUE}2)${NC} Existing project\n"
    printf "  ${RED}0)${NC} Exit setup\n"
    printf "\n"
    read -p "${YELLOW}Choose (1-2, or 0 to exit): ${NC}" PROJECT_SETUP
    
    case $PROJECT_SETUP in
        1) 
            PROJECT_TYPE="fresh" 
            printf "${GREEN}✓${NC} Selected: Fresh new project\n"
            ;;
        2) 
            PROJECT_TYPE="existing" 
            printf "${BLUE}✓${NC} Selected: Existing project\n"
            ;;
        0|exit|quit|q)
            printf "\n${YELLOW}👋 Goodbye! Feel free to run AutoDevKit anytime.${NC}\n\n"
            exit 0
            ;;
        *) 
            printf "\n${RED}❌ Invalid choice. Please select 1, 2, or 0.${NC}\n"
            ask_project_type  # Recursive call to ask again
            return
            ;;
    esac
    
    export PROJECT_TYPE
}

# Ask user about technology stack
ask_technology() {
    printf "\n${BRIGHT_CYAN}🛠  What technology stack are you using?${NC}\n\n"
    printf "  ${BRIGHT_BLUE}1)${NC} ${WHITE}React.js${NC} ${LIGHT_GRAY}(Frontend web app)${NC}\n"
    printf "  ${BRIGHT_PURPLE}2)${NC} ${WHITE}React Native${NC} ${LIGHT_GRAY}(Mobile app)${NC}\n"  
    printf "  ${BRIGHT_GREEN}3)${NC} ${WHITE}Node.js${NC} ${LIGHT_GRAY}(Backend/API)${NC}\n"
    printf "  ${ORANGE}4)${NC} ${WHITE}General JavaScript/TypeScript${NC} ${LIGHT_GRAY}(Universal)${NC}\n"
    printf "  ${RED}0)${NC} Exit setup\n"
    printf "\n"
    read -p "${YELLOW}Choose (1-4, or 0 to exit): ${NC}" TECH_CHOICE
    
    case $TECH_CHOICE in
        1) 
            TECHNOLOGY="react" 
            printf "${BRIGHT_BLUE}✓${NC} Selected: React.js for web development\n"
            ;;
        2) 
            TECHNOLOGY="react-native" 
            printf "${BRIGHT_PURPLE}✓${NC} Selected: React Native for mobile apps\n"
            ;;
        3) 
            TECHNOLOGY="nodejs" 
            printf "${BRIGHT_GREEN}✓${NC} Selected: Node.js for backend development\n"
            ;;
        4) 
            TECHNOLOGY="general" 
            printf "${ORANGE}✓${NC} Selected: General JavaScript/TypeScript\n"
            ;;
        0|exit|quit|q)
            printf "\n${YELLOW}👋 Setup cancelled. Have a great day!${NC}\n\n"
            exit 0
            ;;
        *) 
            printf "\n${RED}❌ Invalid choice. Please select 1, 2, 3, 4, or 0.${NC}\n"
            ask_technology  # Recursive call to ask again
            return
            ;;
    esac
    
    export TECHNOLOGY
}

# Ask user about demo mode
ask_demo_mode() {
    printf "\n${BRIGHT_CYAN}🎬 Do you want to run the demo mode?${NC}\n"
    printf "   ${LIGHT_GRAY}(Creates sample files and shows commit validation in action)${NC}\n\n"
    printf "  ${GREEN}y)${NC} Yes, show me how it works! ${LIGHT_GRAY}(Recommended for first-time users)${NC}\n"
    printf "  ${BLUE}n)${NC} No, just set up the tools\n"
    printf "  ${RED}0)${NC} Exit setup\n"
    printf "\n"
    read -p "${YELLOW}Choose (y/n, or 0 to exit): ${NC}" DEMO_CHOICE
    
    case $DEMO_CHOICE in
        [yY]|[yY][eE][sS]|yes|YES)
            DEMO_MODE="true" 
            printf "${GREEN}✓${NC} Demo mode enabled - you'll see validation in action!\n"
            ;;
        [nN]|[nN][oO]|no|NO)
            DEMO_MODE="false" 
            printf "${BLUE}✓${NC} Demo mode skipped - tools only setup\n"
            ;;
        0|exit|quit|q)
            printf "\n${YELLOW}👋 Setup cancelled. Come back anytime!${NC}\n\n"
            exit 0
            ;;
        *)
            printf "\n${RED}❌ Please enter 'y' for yes, 'n' for no, or '0' to exit.${NC}\n"
            ask_demo_mode  # Recursive call to ask again
            return
            ;;
    esac
    
    export DEMO_MODE
}

# Export functions for use in other scripts
export -f ask_project_type ask_technology ask_demo_mode