function attach
  tmux attach-session -t (tmux ls | cut -d':' -f1 | fzf-tmux)
end
