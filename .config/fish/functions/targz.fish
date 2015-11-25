function targz -d "Create a tar.gz archive of the directory"
  set arg1 (echo $argv | cut -f1 -d' ')
  tar -vczf (basename $arg1).tar.gz $arg1
end
