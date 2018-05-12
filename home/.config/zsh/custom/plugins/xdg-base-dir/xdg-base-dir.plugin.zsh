# enforce XDG Base Directory Specification
# Ref: https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

# bundler
# https://github.com/bundler/bundler/pull/6024
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"

# cargo and rustup
# https://doc.rust-lang.org/cargo/reference/environment-variables.html
# https://github.com/rust-lang-nursery/rustup.rs#choosing-where-to-install
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

# cheat
# https://github.com/chrisallenlane/cheat#setting-a-default_cheat_dir
export DEFAULT_CHEAT_DIR="$XDG_CONFIG_HOME/cheat"

# cocoapods
# https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/config.rb
export CP_HOME_DIR="$XDG_CONFIG_HOME/cocoapods"
export CP_REPOS_DIR="$XDG_CACHE_HOME/cocoapods/repos"
export CP_TEMPLATES_DIR="$XDG_DATA_HOME/cocoapods/templates"

# fpp
# https://github.com/facebook/PathPicker/pull/231
export FPP_DIR="$XDG_CACHE_HOME/fpp"

# jupyter/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# less
export LESSKEY="$XDG_DATA_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
if [[ ! -f "$LESSKEY" ]]; then
    mkdir -p "$XDG_DATA_HOME/less"
    lesskey "$XDG_CONFIG_HOME/less/lesskey"
fi

# npm
# https://github.com/npm/npm/issues/6675
# https://github.com/nodejs/node-gyp/issues/21
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_DEVDIR="$XDG_CACHE_HOME/node-gyp"

# openssl
# https://www.openssl.org/docs/faq.html
export RANDFILE="$XDG_CACHE_HOME/openssl-rnd"

# perl/cpanm
# https://github.com/miyagawa/cpanminus#how-does-cpanm-getparseupdate-the-cpan-index
# Install `local::lib` by `cpanm local::lib`
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5"
export PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"
export PATH="$XDG_DATA_HOME/perl5/bin:$PATH"

# pry
# https://github.com/pry/pry/issues/1316#issuecomment-98436268
export PRYRC="$XDG_CONFIG_HOME/pry/config"

# vagrant
# https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
