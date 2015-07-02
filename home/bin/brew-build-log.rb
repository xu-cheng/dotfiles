fpp = which("fpp")
abort "Please install fpp with `brew instal fpp`." unless fpp

logd = ARGV.resolved_formulae.first.logs
abort "#{logd} doesn't exist." unless logd.directory?

exec "find #{logd} | #{fpp}"
