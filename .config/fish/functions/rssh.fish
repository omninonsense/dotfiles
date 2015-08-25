function rssh
  screen -dmS reverse_ssh ssh -N -R 4722:localhost:22 ssh2.diversentity.net
end
