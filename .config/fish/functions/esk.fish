function esk --description "Add private key to keychain and start keychain"
  set -l IFS # this temporarily clears IFS, which disables the newline-splitting
  eval (keychain --eval --quiet -Q id_rsa)
end
