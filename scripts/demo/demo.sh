#!/bin/bash

# 🎬 Demo functionality for AutoDevKit
# Creates sample files and demonstrates validation features

# Source print functions if not already loaded
if [ -z "$GREEN" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/../ui/print.sh"
fi

# Create demo files based on technology
create_demo_files() {
    if [ "$DEMO_MODE" = "true" ]; then
        print_info "Creating demo files for $TECHNOLOGY..."
        
        case $TECHNOLOGY in
            "react")
                mkdir -p src
                cat > src/App.js << 'EOL'
import React from 'react';

function App() {
  const handleClick = () => {
    console.log('Hello from React!');
  };

  return (
    <div>
      <h1>Hello React!</h1>
      <button onClick={handleClick}>Click me</button>
    </div>
  );
}

export default App;
EOL
                ;;
            "react-native")
                cat > App.js << 'EOL'
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const COLORS = {
  primary: '#007AFF',
};

const App = () => {
  const handlePress = () => {
    // eslint-disable-next-line no-console
    console.log('Hello from React Native!');
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Hello React Native!</Text>
      <TouchableOpacity style={styles.button} onPress={handlePress}>
        <Text>Press me</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    marginBottom: 20,
  },
  button: {
    backgroundColor: COLORS.primary,
    padding: 10,
    borderRadius: 5,
  },
});

export default App;
EOL
                ;;
            "nodejs")
                cat > index.js << 'EOL'
import express from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Hello from Node.js!' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOL
                ;;
            *)
                cat > index.js << 'EOL'
// Demo JavaScript file
const greet = (name) => {
  console.log(`Hello, ${name}!`);
  return `Hello, ${name}!`;
};

const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(num => num * 2);

console.log('Doubled numbers:', doubled);
greet('Developer');
EOL
                ;;
        esac
        
        print_success "Demo files created!"
    fi
}

# Run interactive demo
run_demo() {
    if [ "$DEMO_MODE" = "true" ]; then
        printf "\n${PURPLE}🎬 DEMO MODE: Let's see the validation in action!${NC}\n\n"
        
        # Initialize git if not already initialized (needed for demo)
        if [ ! -d ".git" ]; then
            print_info "Initializing Git for demo..."
            git init
            # Configure git hooks path for demo
            git config core.hooksPath .husky
        fi
        
        # Stage the demo files
        git add .
        
        print_info "Step 1: Trying to commit with bad message..."
        printf "\n${YELLOW}Command: git commit -m \"bad commit message\"${NC}\n"
        
        # Try bad commit (should fail)
        if git commit -m "bad commit message" 2>/dev/null; then
            print_error "Commit should have been rejected but wasn't!"
        else
            print_success "✅ Bad commit message was rejected! (As expected)"
        fi
        
        # Reset to try again
        git reset --soft HEAD~1 2>/dev/null || true
        
        printf "\n${BLUE}📦 Step 2: Fixing the code and using proper commit message...${NC}\n"
        print_info "Trying proper commit message..."
        printf "${YELLOW}Command: git commit -m \"feat: add demo files for $TECHNOLOGY project\"${NC}\n"
        
        # Try good commit (should work)
        if git commit -m "feat: add demo files for $TECHNOLOGY project"; then
            print_success "✅ Proper commit message accepted!"
        else
            print_error "Commit failed - there might still be linting issues"
        fi
        
        printf "\n${GREEN}🎉 Demo completed! Your setup is working perfectly!${NC}\n"
    fi
}

# Export functions
export -f create_demo_files run_demo