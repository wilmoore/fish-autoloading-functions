function gist-list
  set FILTER '.[] | "\(.id) \(.updated_at) \(.git_pull_url) \(.public) \(.description)"'
  set H_AUTH "Authorization: token $GIST_GITHUB_API_TOKEN"

  if test "$GIST_GITHUB_API_TOKEN" = ""
    echo 'Create a personal access token with `gist` scope and export as `GIST_GITHUB_API_TOKEN`'
    echo ''

    echo '> security add-generic-password -U -a $USER -s GIST_GITHUB_API_TOKEN -w *******'
    echo '> set -x GIST_GITHUB_API_TOKEN (security find-generic-password -s GIST_GITHUB_API_TOKEN -w)'
    echo ''

    echo 'https://github.com/settings/tokens/new?scopes=gist&description=GIST_GITHUB_API_TOKEN'
    return 1
  end

  set CACHEDIR "$XDG_CACHE_HOME/gist"
  test -d $CACHEDIR || mkdir -p $CACHEDIR

  # purge files older than 1 hour
  find $XDG_CACHE_HOME/gist -type f -mmin +60 | xargs rm -f -

  set LASTPAGE (curl -s -I -H "Authorization: token $GIST_GITHUB_API_TOKEN" 'https://api.github.com/gists?per_page=100' | grep -i '^link:' | tr '<' '\n' | grep -i 'rel="last"' | cut -d '>' -f 1 | awk -F '=' '{ print $NF }')

  set currentpage 0

  while true
    set currentpage (math "$currentpage + 1")
    set PAGEFILE "$CACHEDIR/gists.$currentpage"
    # printf 'Last: %s, Current: %s\n' $LASTPAGE $currentpage

    # create pagefile if it does not exist
    if test ! -e "$PAGEFILE"
      curl -s -H $H_AUTH "https://api.github.com/gists?page=$currentpage&per_page=100" | jq --raw-output $FILTER > "$PAGEFILE"
    end

    # break loop after last page
    if test $LASTPAGE -eq $currentpage 
      break
    end
  end

  cat $CACHEDIR/gists.*
end
