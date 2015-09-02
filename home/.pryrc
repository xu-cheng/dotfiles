# vim: filetype=ruby

%w[
  pry-byebug
  pry-coolline
  pry-stack_explorer
  pry-theme
  pry-toys
].each do |g|
  begin
    gem g
  rescue Gem::LoadError
    puts "Installing #{g}... (require restarting pry)"
    unless system "gem", "install", g
      puts "WARNING: fail to install #{g}."
    end
  end
end

if defined?(PryByebug)
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
