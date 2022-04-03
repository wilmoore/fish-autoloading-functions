function gist-clone
  if test (count $argv) -eq 0
    echo "gist-clone [id]"
    return 1
  end

  set GIST_ID $argv[1]
  echo $GIST_ID
  set GIST_URL https://gist.github.com/$GIST_ID.git
  set GIST_CLONE_PATH (mktemp -d)/$GIST_ID
  git clone $GIST_URL $GIST_CLONE_PATH
  cd $GIST_CLONE_PATH
end
