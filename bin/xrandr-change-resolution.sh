#!/bin/bash

# Check if all required parameters are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <display_name> <width> <height>"
    echo "Example: $0 HDMI-1 2560 1600"
    exit 1
fi

if ! command -v xrandr &> /dev/null; then
    echo "Error: Command 'xrandr' not found. Please install it."
    exit 1
fi

DISPLAY_NAME=$1
WIDTH=$2
HEIGHT=$3
MODE_NAME="${WIDTH}x${HEIGHT}"

# Function to check if the resolution already exists
check_resolution() {
    xrandr --query | grep "$MODE_NAME" > /dev/null
    return $?
}

# Function to check if the display exists
check_display() {
    xrandr --query | grep "^$DISPLAY_NAME" > /dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Display $DISPLAY_NAME not found"
        exit 1
    fi
}

# Main script
check_display

if check_resolution; then
    echo "Resolution $MODE_NAME already exists. Setting it directly..."
    xrandr --output "$DISPLAY_NAME" --mode "$MODE_NAME"
else

    if ! command -v cvt &> /dev/null; then
        echo "Error: Command 'cvt' not found. Please install it."
        exit 1
    fi

    echo "Resolution $MODE_NAME not found. Creating new mode..."

    # Generate modeline using cvt
    CVT_OUTPUT=$(cvt "$WIDTH" "$HEIGHT" | grep Modeline)

    if [ -z "$CVT_OUTPUT" ]; then
        echo "Error: Failed to generate modeline"
        exit 1
    fi

    # Extract the modeline parameters
    MODELINE=$(echo "$CVT_OUTPUT" | cut -d' ' -f 2-)

    # Remove the quotes from the mode name
    MODELINE_PARAMS=$(echo "$MODELINE" | cut -d' ' -f 2-)

    # Create new mode
    echo "Adding new mode..."
    xrandr --newmode "$MODE_NAME" $MODELINE_PARAMS

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create new mode"
        exit 1
    fi

    # Add mode to the display
    echo "Adding mode to display..."
    xrandr --addmode "$DISPLAY_NAME" "$MODE_NAME"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to add mode to display"
        exit 1
    fi

    # Set the new mode
    echo "Setting new mode..."
    xrandr --output "$DISPLAY_NAME" --mode "$MODE_NAME"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to set new mode"
        exit 1
    fi

    echo "Successfully set new resolution $MODE_NAME"
fi
