#!/bin/bash

# Determine shell configuration file
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    echo "Neither .zshrc nor .bashrc was found in your home directory."
    exit 1
fi

# Create the bin directory if it doesn't exist
mkdir -p "$HOME/bin"

# Create the startloc script
STARTLOC_PATH="$HOME/bin/startloc"
if [ ! -f "$STARTLOC_PATH" ]; then
cat << 'EOF' > "$STARTLOC_PATH"
#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: startloc <path>"
    exit 1
fi
TARGET_PATH=$(realpath "$1")
echo $TARGET_PATH > ~/.startlocpath

EOF
chmod +x "$STARTLOC_PATH"
echo "startloc script created."
else
    echo "startloc script already exists."
fi

# Add bin to PATH in shell config file if it's not already
if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$SHELL_CONFIG"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_CONFIG"
    echo "PATH updated."
fi

# Add cd command to shell config file if it's not already
CD_CMD='if [ -f ~/.startlocpath ]; then STARTLOC_PATH=$(cat ~/.startlocpath); if [ -d "$STARTLOC_PATH" ]; then cd "$STARTLOC_PATH"; ENV_DIR="$STARTLOC_PATH/env"; if [ -d "$ENV_DIR" ] && [ -f "$ENV_DIR/bin/activate" ]; then source "$ENV_DIR/bin/activate"; fi; else echo "startloc path not found: $STARTLOC_PATH"; fi; fi'
if ! grep -q 'STARTLOC_PATH=$(cat ~/.startlocpath)' "$SHELL_CONFIG"; then
    echo "$CD_CMD" >> "$SHELL_CONFIG"
    echo "Auto-cd added to $SHELL_CONFIG."
else
    echo "Auto-cd already present in $SHELL_CONFIG."
fi
