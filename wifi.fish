function wifi
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | \
  grep -F ' SSID:' | \
  cut -d: -f2 | \
  sed -e 's/^[[:space:]]*//'
end
