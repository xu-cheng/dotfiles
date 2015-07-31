# copied from https://github.com/jacknagel/dotfiles/blob/master/bin/brew-for-each-formula.rb
require "formula"
Formula.each { |f| eval(ARGV.first) }
