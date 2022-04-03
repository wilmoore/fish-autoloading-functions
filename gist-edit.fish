function gist-edit
  rm -rf $XDG_CACHE_HOME/gist/*
  gist-clone (gist-list | fzf | awk '{ print $1 }')
  $EDITOR readme.md
end
