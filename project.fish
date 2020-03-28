function project
  if [ (count $argv) -eq 0 ];
    echo "project [path][ --detached]"
    return 1
  end

  # see `realpath .` for context
  set project_path (realpath $argv[1])

  # get the basename, replace characters '.' and '@' with '_'
  set project_name (basename $project_path | tr '.' '_' | tr '@' '_')

  if test -d "$project_path"
    if test (count $argv) -eq 2 -a "$argv[2]" = "--detached"
      tmux has-session -t "$project_name" 2>/dev/null

      if test ! $status -eq 0
        tmux -2 new-session -d -c $project_path -s "$project_name" -n "$project_name"
      end
    else
      # new session, force 256 colors, attach if session exists, set start path to project path, name session and window,
      tmux -2 new-session -AD -c $project_path -s "$project_name" -n "$project_name"
    end
  else
    echo "~\$ mkdir -p '$project_path'"
  end
end

# complete existing tmux sessions
complete -x -c project -d 'session' -s n -x -a '(tmux ls | cut -d: -f1)'

# "borrow" completions from `cd`
complete -c project -w cd
