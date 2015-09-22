function plasma5-restart -d "Restart plasma to fix common issues"
  command kbuildsycoca5
  command kquitapp plasmashell
  command kstart plasmashell > /dev/null ^ /dev/null
end
