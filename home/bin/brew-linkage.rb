# copied from https://github.com/jacknagel/dotfiles/blob/caceafc/bin/brew-linkage.rb
require "set"
require "keg"
require "formula"

ARGV.kegs.each do |keg|
  brewed_dylibs = Hash.new { |h, k| h[k] = Set.new }
  system_dylibs = Set.new
  broken_dylibs = Set.new

  keg.find do |file|
    if file.dylib? || file.mach_o_executable? || file.mach_o_bundle?
      file.dynamically_linked_libraries.each do |dylib|
        begin
          owner = Keg.for Pathname.new(dylib)
        rescue NotAKegError
          system_dylibs << dylib
        rescue Errno::ENOENT
          broken_dylibs << dylib
        else
          brewed_dylibs[owner.name] << dylib
        end
      end
    end
  end

  unless system_dylibs.empty?
    puts "System libraries:"
    system_dylibs.sort.each do |dylib|
      puts "  #{dylib}"
    end
  end

  unless brewed_dylibs.empty?
    puts "Homebrew libraries:"
    brewed_dylibs.sort.each do |name, dylibs|
      dylibs.each do |dylib|
        puts "  #{dylib} (#{name})"
      end
    end
  end

  unless broken_dylibs.empty?
    puts "Missing libraries:"
    broken_dylibs.sort.each do |dylib|
      puts "  #{dylib}"
    end
  end

  begin
    f = Formula[keg.name]
  rescue FormulaUnavailableError
    next
  end

  undeclared_deps = brewed_dylibs.keys - f.deps.map(&:name)
  undeclared_deps -= [f.name]

  unless undeclared_deps.empty?
    puts "Possible undeclared dependencies:"
    puts "  #{undeclared_deps * ", "}"
  end
end
