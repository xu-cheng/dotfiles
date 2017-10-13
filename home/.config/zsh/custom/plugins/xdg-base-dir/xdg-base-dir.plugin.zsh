# enforce XDG Base Directory Specification
# Ref: https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

# bundler
# https://github.com/bundler/bundler/pull/6024
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"

# cheat
# https://github.com/chrisallenlane/cheat#setting-a-default_cheat_dir
export DEFAULT_CHEAT_DIR="$XDG_CONFIG_HOME/cheat"

# cpanm
# https://github.com/miyagawa/cpanminus#how-does-cpanm-getparseupdate-the-cpan-index
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"

# fpp
# https://github.com/facebook/PathPicker/pull/231
export FPP_DIR="$XDG_CACHE_HOME/fpp"

# jupyter/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# less
export LESSKEY="$XDG_CONFIG_HOME/less/less"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# pry
# https://github.com/pry/pry/issues/1316#issuecomment-98436268
export PRYRC="$XDG_CONFIG_HOME/pry/config"

# vagrant
# https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
