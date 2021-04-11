if command -vq ruby
  # Enable Chruby
  if test -e /usr/local/share/chruby/chruby.fish
      source /usr/local/share/chruby/chruby.fish
  end

  if test -e /usr/local/share/chruby/auto.fish
      source /usr/local/share/chruby/auto.fish
  end

  set GEM_USER_DIR (ruby -e 'puts Gem.user_dir')
  add_to_path "$GEM_USER_DIR/bin"

  # Add common abbreviations
  abbr -a be bundle exec

  # https://github.com/fohte/rubocop-daemon#use-with-bundler
  set -x RUBOCOP_DAEMON_USE_BUNDLER true

  # add_to_path "/usr/local/bin/rubocop-daemon-wrapper"
end
