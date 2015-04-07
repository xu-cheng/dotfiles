require "formula"

p = ARGV.formulae[0].path
system "pygmentize", "-g", p
