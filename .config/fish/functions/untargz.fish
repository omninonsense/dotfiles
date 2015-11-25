function untargz -d "Extract tar.gz archive into a directory"
  set arg1 (echo $argv | cut -f1 -d' ')
  set target (basename $arg1 .tar.gz)

  mkdir $target
  tar -xzvf $arg1
end
