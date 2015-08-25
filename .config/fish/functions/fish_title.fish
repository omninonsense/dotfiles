function ssh_title -d "Set SSH title"
  set -l hostname

  echo (echo $argv[1]| sed 's| -[[:alnum:]]*||g' | cut -d' ' -f 2) | read -la hostname

  # Misc cases
  set hostname (echo $hostname | sed 's|ssh2.diversentity.net$|diversentity|g')

  # Plus Hosting cases
  set hostname (echo $hostname | sed 's|.plusvps.com$||g')
  set hostname (echo $hostname | sed 's|.mojsite.com$||g')
  set hostname (echo $hostname | sed 's|.plus.hr$||g')

  echo $hostname
  return 0
end

function fish_title
  if set -q context_title
    echo $context_title
  else if set -q argv[1]

    switch (echo $argv[1] | cut -d' ' -f 1);
    case ssh;
      ssh_title $argv[1]
    end

  else
    hostname
  end

  return 0
end
