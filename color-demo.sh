#!/bin/bash

# 🎨 Color Demonstration for AutoDevKit
# Shows all available colors and their usage

# Source the colors
source scripts/ui/colors.sh

echo -e "\n🎨 AutoDevKit Color Palette Demo\n"

echo "🌈 Basic Colors:"
echo -e "  ${GREEN}GREEN${NC} - Success messages, confirmations"
echo -e "  ${BLUE}BLUE${NC} - Information, selections"  
echo -e "  ${RED}RED${NC} - Errors, exit options"
echo -e "  ${YELLOW}YELLOW${NC} - Warnings, prompts"
echo -e "  ${PURPLE}PURPLE${NC} - Headers, decorative"
echo -e "  ${CYAN}CYAN${NC} - Questions, interactive"

echo -e "\n✨ Bright Colors:"
echo -e "  ${BRIGHT_GREEN}BRIGHT_GREEN${NC} - Enhanced success"
echo -e "  ${BRIGHT_BLUE}BRIGHT_BLUE${NC} - Enhanced info"
echo -e "  ${BRIGHT_RED}BRIGHT_RED${NC} - Enhanced errors"
echo -e "  ${BRIGHT_YELLOW}BRIGHT_YELLOW${NC} - Enhanced warnings"
echo -e "  ${BRIGHT_PURPLE}BRIGHT_PURPLE${NC} - Enhanced headers"
echo -e "  ${BRIGHT_CYAN}BRIGHT_CYAN${NC} - Enhanced questions"

echo -e "\n🎭 Extended Palette:"
echo -e "  ${WHITE}WHITE${NC} - Important text, selections"
echo -e "  ${ORANGE}ORANGE${NC} - Special options (General JS)"
echo -e "  ${MAGENTA}MAGENTA${NC} - Special highlights"
echo -e "  ${LIGHT_GRAY}LIGHT_GRAY${NC} - Descriptions, help text"
echo -e "  ${DARK_GRAY}DARK_GRAY${NC} - Subtle text"

echo -e "\n🎨 Background Colors:"
echo -e "  ${BG_RED}${WHITE} ERROR BACKGROUND ${NC}"
echo -e "  ${BG_GREEN}${WHITE} SUCCESS BACKGROUND ${NC}"
echo -e "  ${BG_YELLOW}${WHITE} WARNING BACKGROUND ${NC}"
echo -e "  ${BG_BLUE}${WHITE} INFO BACKGROUND ${NC}"

echo -e "\n🚀 Usage Example:"
echo -e "${BRIGHT_CYAN}🤔 What's your favorite color?${NC}"
echo -e "  ${GREEN}1)${NC} ${WHITE}Green${NC} ${LIGHT_GRAY}(Nature vibes)${NC}"
echo -e "  ${BLUE}2)${NC} ${WHITE}Blue${NC} ${LIGHT_GRAY}(Ocean vibes)${NC}"
echo -e "  ${RED}0)${NC} Exit"
echo -e ""
echo -e "${YELLOW}Choose (1-2, or 0 to exit): ${NC}[This would be your input]"
echo -e "${GREEN}✓${NC} Selected: Your choice here!"

echo -e "\n💡 How to Use These Colors:"
echo "1. Edit scripts/ui/colors.sh to modify color definitions"
echo "2. Run ./dev.sh build to update the single file"
echo "3. Use \${COLOR_NAME} in your text and end with \${NC}"
echo "4. Example: printf \"\${BRIGHT_GREEN}Success!\${NC}\\n\""

echo -e "\n🔧 To customize colors:"
echo "1. Open scripts/ui/colors.sh"
echo "2. Modify existing color codes"
echo "3. Add new color definitions"
echo "4. Export them at the bottom"
echo "5. Rebuild with ./dev.sh build"

echo -e "\n✅ ${BRIGHT_GREEN}Color demo complete!${NC}\n"