function attach
  set session (tmux ls 2>/dev/null | cut -d':' -f1 | fzf)
  test -n "$session" && tmux attach-session -t $session
end
