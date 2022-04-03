function gist-create
  if [ (count $argv) -eq 0 ];
    echo "gist-create [description]"
    return 1
  end

  set GIST_DESCRIPTION "$argv[1]"

  curl -sH "Authorization: token $GIST_GITHUB_API_TOKEN" \
    -X POST \
    --data "{\"description\":\"$GIST_DESCRIPTION\",\"public\":\"false\",\"files\":{\"readme.md\":{\"content\":\"# $GIST_DESCRIPTION\"}}" \
    https://api.github.com/gists && rm -rf $XDG_CACHE_HOME/gist/*
end
