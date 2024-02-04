function url-query-code
  echo $argv | awk -F '[=&]' '{ print $2 }'
end
