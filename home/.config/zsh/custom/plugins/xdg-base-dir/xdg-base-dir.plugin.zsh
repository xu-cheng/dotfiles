# enforce XDG Base Directory Specification
# Ref: https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

# asdf
# https://github.com/asdf-vm/asdf/issues/687
export ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/pip/default-python-packages
export ASDF_NPM_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/npm/default-npm-packages
export ASDF_GEM_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/gem/default-gems

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

# cocoapods
# https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/config.rb
export CP_HOME_DIR="$XDG_CONFIG_HOME/cocoapods"
export CP_REPOS_DIR="$XDG_CACHE_HOME/cocoapods/repos"
export CP_TEMPLATES_DIR="$XDG_DATA_HOME/cocoapods/templates"

# fpp
# https://github.com/facebook/PathPicker/pull/231
export FPP_DIR="$XDG_CACHE_HOME/fpp"

# httpie
# https://github.com/jakubroztocil/httpie#config-file-location
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# jupyter/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# less
export LESSKEYIN="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

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
# https://metacpan.org/pod/local::lib
# https://github.com/miyagawa/cpanminus/tree/devel/App-cpanminus#how-does-cpanm-getparseupdate-the-cpan-index
# Install `local::lib` by `cpanm local::lib`
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5"
export PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"
export PATH="$XDG_DATA_HOME/perl5/bin:$PATH"

# python
# https://docs.python.org/3/library/readline.html?highlight=readline#example
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# vagrant
# https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
