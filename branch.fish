function branch
  git checkout (git branch | awk -F '[* ]' '{ print $3 }' | fzf-tmux)
end
