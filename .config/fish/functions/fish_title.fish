function fish_title
  if set -q context_title
    echo $context_title
  else
    echo $USER (prompt_pwd)
  end

  return 0
end
