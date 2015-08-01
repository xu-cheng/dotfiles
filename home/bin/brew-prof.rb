ENV["HOMEBREW_BREW_FILE"] = HOMEBREW_PREFIX/"bin/brew"
brew_rb = (HOMEBREW_LIBRARY_PATH/"../brew.rb").resolved_path
FileUtils.mkdir_p "prof"
exec "ruby-prof", "--printer=multi", "--file=prof", brew_rb, "--", *ARGV
