function touch_toggle -d "Toggle Grabic tablet touch"
  set -l device "Wacom Intuos Pro S (WL) Finger touch"
  set -l param "touch"

  set -l state (command xsetwacom --get "$device" $param)

  if [ $state = 'off' ]
    command xsetwacom --set "$device" $param on
  else
    command xsetwacom --set "$device" $param off
  end
end
