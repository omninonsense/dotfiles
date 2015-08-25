function transmission-remote -d "Connect to transmission daemon"
  command transmission-remote 9092 -ne $argv
end
