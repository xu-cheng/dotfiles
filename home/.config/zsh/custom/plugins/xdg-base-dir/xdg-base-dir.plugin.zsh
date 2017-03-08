# enforce XDG Base Directory Specification
# Ref: https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

# cheat
# https://github.com/chrisallenlane/cheat#setting-a-default_cheat_dir
export DEFAULT_CHEAT_DIR="$XDG_CONFIG_HOME/cheat"

# cpanm
# https://github.com/miyagawa/cpanminus#how-does-cpanm-getparseupdate-the-cpan-index
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"

# fpp
# https://github.com/facebook/PathPicker/pull/231
export FPP_DIR="$XDG_CACHE_HOME/fpp"

# vagrant
# https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
