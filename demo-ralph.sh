#!/bin/bash
# Ralph Loop for OpenCode
# Usage: ralph.sh [max_iterations]
# Run from your project root directory
# 
# Installation: Copy this file to ~/.local/bin/demo-ralph.sh

set -e

MAX_ITERATIONS=${1:-10}
RALPH_DIR="./ralph"
PRD_FILE="$RALPH_DIR/prd.json"
PROGRESS_FILE="$RALPH_DIR/progress.txt"

# Check if ralph directory exists
if [ ! -d "$RALPH_DIR" ]; then
  echo "Creating ralph directory..."
  mkdir -p "$RALPH_DIR"
fi

# Check if PRD exists
if [ ! -f "$PRD_FILE" ]; then
  echo "Error: No prd.json found at $PRD_FILE"
  echo ""
  echo "Create one first:"
  echo "  1. Run: opencode"
  echo "  2. Type: /prd-create [your feature description]"
  echo "  3. Then: /ralph-convert"
  exit 1
fi

# Initialize progress file
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "# Ralph Progress Log" > "$PROGRESS_FILE"
  echo "Project: $(jq -r '.project' "$PRD_FILE")" >> "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "---" >> "$PROGRESS_FILE"
fi

# Show status
echo "╔═══════════════════════════════════════════════════════╗"
echo "║                    RALPH FOR OPENCODE                 ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "Project:    $(jq -r '.project' "$PRD_FILE")"
echo "Branch:     $(jq -r '.branchName' "$PRD_FILE")"
echo "Stories:    $(jq '[.userStories[] | select(.passes == true)] | length' "$PRD_FILE")/$(jq '.userStories | length' "$PRD_FILE") complete"
echo "Max Iters:  $MAX_ITERATIONS"
echo ""

for i in $(seq 1 $MAX_ITERATIONS); do
  echo "═══════════════════════════════════════════════════════"
  echo "  Iteration $i of $MAX_ITERATIONS"
  echo "═══════════════════════════════════════════════════════"
  
  # Run opencode with the ralph-iterate command
  OUTPUT=$(opencode run --command ralph-iterate 2>&1 | tee /dev/stderr) || true
  
  # Check for completion signal
  if echo "$OUTPUT" | grep -q "<ralph>COMPLETE</ralph>"; then
    echo ""
    echo "╔═══════════════════════════════════════════════════════╗"
    echo "║              RALPH COMPLETED ALL TASKS!               ║"
    echo "╚═══════════════════════════════════════════════════════╝"
    echo "Finished at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi
  
  echo ""
  echo "Iteration $i complete. Continuing in 2s..."
  sleep 2
done

echo ""
echo "Ralph reached max iterations ($MAX_ITERATIONS)."
echo "Check ./ralph/progress.txt for status."
exit 1
