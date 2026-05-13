#!/bin/bash

SESSION="bingetube"

# Check if session exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # 1. Create session (detached) and the first window
  tmux new-session -d -s $SESSION
  
  # --- UI TWEAKS ---
  # Remove the colons and names: only show window index
  tmux set-option -t $SESSION window-status-format " #I "
  tmux set-option -t $SESSION window-status-current-format " #I "
  # Optional: Clear the left side (session name) for a cleaner look
  tmux set-option -t $SESSION status-left ""

  # 2. Setup Windows & Panes
  # Window 1: Editor
  tmux send-keys -t $SESSION:1 "nvim ." C-m

  # Window 2: Runners (Vertical Split)
  tmux new-window -t $SESSION:2
  tmux split-window -v -t $SESSION:2
  tmux send-keys -t $SESSION:2.1 "flutter analyze --watch" C-m
  tmux send-keys -t $SESSION:2.2 "cd website && npm run dev" C-m

  # Window 3: Git
  tmux new-window -t $SESSION:3
  tmux send-keys -t $SESSION:3 "lazygit" C-m

  # Window 4: Command (Empty)
  tmux new-window -t $SESSION:4

  # 3. Select the starting window
  tmux select-window -t $SESSION:1
fi

# Attach to the session
tmux attach-session -t $SESSION
