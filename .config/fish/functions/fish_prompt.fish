function fish_prompt --description 'Write out the prompt'
  set -l color_cwd
  set -l suffix
  set -l git_branch (git branch ^/dev/null | cut -d' ' -f2)
  set -l branch_name ''

  switch $USER
  case root toor
    if set -q fish_color_cwd_root
      set color_cwd $fish_color_cwd_root
    else
      set color_cwd $fish_color_cwd
    end
    set suffix '#'
  case '*'
    set color_cwd $fish_color_cwd
    set suffix '>'
  end

  if [ "$git_branch" ]
    set branch_name ' ' (set_color yellow) $git_branch (set_color normal)
  end

  echo -n -s (set_color blue) "$USER" (set_color normal) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) $branch_name "$suffix "
end
