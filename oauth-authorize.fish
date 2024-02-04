function oauth-authorize
  echo "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?response_type=code&response_mode=query&client_id=$client_id&redirect_uri=$redirect_uri&scope=$scope&state=$(uuidgen)"
end
