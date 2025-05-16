#!/usr/bin/env bash

# Wait for the session to be created
echo "Simulating creating a layout via cli..."

echo "Step 1: Creating a new tab named 'CLI'"
sleep 3
zellij action new-tab --name "CLI"

echo "Step 2: Moving the tab to the left"
sleep 1
zellij action move-tab left

echo "Step 3: Writing the first command in the current pane"
# Run the first command in the current pane
sleep 1
zellij action write-chars "bun server.js 3002 TEST"


echo "Step 4: Executing the first command"
sleep 1
zellij action write-chars $'\n'


echo "Step 5: Creating a new pane below"
sleep 1
# Create a new pane below
zellij action new-pane --direction down

# Wait for the pane to be created
echo "Step 6: Writing the second command in the new pane"
sleep 1
# Run the second command in the new pane
zellij action write-chars "just dev-cli"

echo "Step 7: Executing the second command"
sleep 1
zellij action write-chars $'\n'

echo "Done"
zellij action go-to-next-tab 


echo "------------------------"
echo ""
echo "Curling spawned servers:"
echo ""

./echo.sh

echo ""
echo "This should show a response from all 4 servers"
echo ""
echo ""
echo "You may now close this session via \`Ctrl + Q\`"

exit 0