function oauth-extract-code
  echo $argv[1] | cut -d '=' -f2 | cut -d '&' -f1
end
