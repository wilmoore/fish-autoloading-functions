function node-latest
  nvm use (nvm list | awk -F'[v.]' '{ print $2 }' | tail -1)
end
