require "formula"
require "formulary"

usage = <<-EOS.undent
  brew testcheck
  brew testcheck --installed
EOS

if ARGV.flag?("--help")
  puts usage
  exit 0
end

if ARGV.include?("--installed")
  formulae = Formula.installed
else
  formulae = Formula
end

formulae = formulae.reject(&:test_defined?)
puts_columns formulae.map(&:to_s), formulae.reject(&:core_formula?).map(&:to_s)
