# vim: set filetype=ruby:

#plugins list
(%w[
  pry-byebug
  pry-coolline
  pry-highlight
  pry-theme
  pry-toys
] - Pry.plugins.values.map(&:gem_name)).each do |plugin|
  puts "Installing #{plugin}..."
  Gem.install plugin
  Gem.refresh
  begin
    require plugin
  rescue LoadError
    puts "WARNING: fail to install #{plugin}."
  end
end

if defined?(PryByebug) && Byebug.started?
  Pry.commands.alias_command "c", "continue"
  Pry.commands.alias_command "s", "step"
  Pry.commands.alias_command "n", "next"
  Pry.commands.alias_command "f", "finish"

  # Hit Enter to repeat last command
  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end
end

if defined?(PryTheme)
  Pry.config.theme = "pry-classic-256"
end
