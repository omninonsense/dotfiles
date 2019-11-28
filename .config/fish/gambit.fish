if status --is-interactive
  abbr --add k1 kubectl --context=k1
  abbr --add k2 kubectl --context=k2
  abbr --add k3 kubectl --context=k3
  
  abbr --add k3m kubectl --context=k3 -n molly-prod
  abbr --add k3l kubectl --context=k3 -n lubyanka
end
