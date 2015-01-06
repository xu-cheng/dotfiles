#!/bin/bash

PREFIX="${HOME}/usr"
BOOTSTRAP_TMP="/tmp/$(whoami)/bootstrap"
export PATH="${PREFIX}/bin:${PATH}"
export HOMEBREW_CACHE="/tmp/$(whoami)/Homebrew/Cache"
export HOMEBREW_LOGS="/tmp/$(whoami)/Homeberw/Logs"

ohai()
{
    echo -e "\033[1;34m==>\033[1;39m ${1}\033[0m"
}

oh1()
{
    echo -e "\033[1;32m==>\033[1;39m ${1}\033[0m"
}

oopo()
{
    echo -e "\033[4;31mWarning\033[0m: ${1}"
}

odie()
{
    echo -e "\033[4;31mError\033[0m: ${1}"
    exit 1
}

ocurl() # $1 - url $2 - name $3 - hash $4 - hash_program
{
    ohai "Download ${2}"
    [[ -f ${2} ]] || curl -#L "${1}" -o "${2}"
    (echo -e "${3}  ${2}\n" | ${4} -c -) || odie "wrong hash for ${2}"
}

ARGV=$*
oargv_include()
{
    for var in $ARGV
    do
        if [[ "$var" == "$1" ]]; then
            return 0
        fi
    done
    return 1
}

if ! curl --connect-timeout 3 "https://www.google.com" >/dev/null 2>&1; then
    odie "SSL connection not available."
fi

[[ -d "$BOOTSTRAP_TMP" ]] || mkdir -p "$BOOTSTRAP_TMP"
[[ -d "$HOMEBREW_LOGS" ]] || mkdir -p "$HOMEBREW_LOGS"
[[ -d "$HOMEBREW_CACHE" ]] || mkdir -p "$HOMEBREW_CACHE"

cd "$BOOTSTRAP_TMP"

if [[ -f "${PREFIX}/lib/libyaml.a" ]] || [[ -f /usr/local/lib/libyaml.a ]] || [[ -f /usr/lib/libyaml.a ]]; then
    oh1 "Found libyaml, skip install."
else
    LIBYAML_URL="http://pyyaml.org/download/libyaml/yaml-0.1.6.tar.gz"
    LIBYAML_HASH="f3d404e11bec3c4efcddfd14c42d46f1aabe0b5d"
    ocurl $LIBYAML_URL yaml.tar.gz $LIBYAML_HASH sha1sum
    ohai "Install libyaml"
    tar -xzf ./yaml.tar.gz
    pushd ./yaml-0.1.6
    ./configure --prefix="${PREFIX}"
    make
    make install
    popd
fi

if which ruby >/dev/null 2>&1 && [[ $(ruby -e "puts RUBY_VERSION") > "1.9.0" ]]; then
    oh1 "Found ruby version > 1.9.0, skip install."
else
    RUBY_URL="http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.bz2"
    RUBY_HASH="1c031137999f832f86be366a71155113675b72420830ce432b777a0ff4942955"
    ocurl $RUBY_URL ruby.tar.gz $RUBY_HASH sha256sum
    ohai "Install ruby"
    tar -xjf ./ruby.tar.gz
    pushd ./ruby-2.2.0
    ./configure --prefix="${PREFIX}" --enable-shared --disable-silent-rules --disable-install-doc --without-gmp --with-opt-dir="${PREFIX}"
    make
    make install
    popd
fi

if which git >/dev/null 2>&1 && [[ $(git --version 2>&1 | awk '/version/{print $NF;exit}') > "2.2.0" ]]; then
    oh1 "Found git version > 2.2.0, skip install."
else
    GIT_URL="https://www.kernel.org/pub/software/scm/git/git-2.2.1.tar.gz"
    GIT_HASH="02ae13b144fa5b83733987791cacaa3de855ff0b"
    ocurl $GIT_URL git.tar.gz $GIT_HASH sha1sum
    ohai "Install git"
    tar -xzf ./git.tar.gz
    pushd ./git-2.2.1
    make prefix="${PREFIX}" install
    popd
fi

if which brew >/dev/null 2>&1; then
    oh1 "Found linuxbrew, skip install."
else
    ohai "Install linuxbrew"
    pushd "${PREFIX}"
    git init -q
    git remote add origin https://github.com/Homebrew/linuxbrew.git
    git fetch origin master:refs/remotes/origin/master -n --depth=1
    git reset --hard origin/master
    popd
fi

if ! oargv_include "--with-gcc"; then
    if ! [[ -f "${PREFIX}/bin/gcc-$(gcc -dumpversion |cut -d. -f1,2)" ]];then
        ohai "Link gcc to linuxbrew"
        ln -s "$(which gcc)" "${PREFIX}/bin/gcc-$(gcc -dumpversion |cut -d. -f1,2)"
        ln -s "$(which g++)" "${PREFIX}/bin/g++-$(g++ -dumpversion |cut -d. -f1,2)"
        ln -s "$(which gfortran)" "${PREFIX}/bin/gfortran-$(gcc -dumpversion |cut -d. -f1,2)"
    fi
else
    if brew ls gcc >/dev/null 2>&1; then
        oh1 "Found linuxbrew gcc, skip install."
    else
        ohai "Install linuxbrew gcc"
        OLD_PATH="$PATH"
        TMP_BIN="$BOOTSTRAP_TMP/bin"
        GCC_VERSION=$(gcc -dumpversion | cut -d. -f1,2)
        [[ -d $TMP_BIN ]] || mkdir -p "$TMP_BIN"
        ln -s "$(which gcc)" "$TMP_BIN/gcc-$GCC_VERSION"
        ln -s "$(which g++)" "$TMP_BIN/g++-$GCC_VERSION"
        ln -s "$(which gfortran)" "$TMP_BIN/gfortran-$GCC_VERSION"
        export PATH="$TMP_BIN:$PATH"
        brew install gcc
        rm -rf "$TMP_BIN"
        export PATH="$OLD_PATH"
    fi
fi

ohai "Install Packages"
brew update
if ! oargv_include "--no-zsh"; then
    brew install zsh zsh-syntax-highlighting
fi
brew install openssl curl autojump hub
if ! oargv_include "--no-python"; then
    brew install python
fi
brew upgrade
brew cleanup

if [[ -d "$HOME/.oh-my-zsh" ]] || oargv_include "--no-zsh"; then
    if oargv_include "--no-zsh"; then
        cat <<EOS
Please add below codes into your .bashrc
    export PATH="\$HOME/usr/bin:\$PATH"
    export MANPATH="\$HOME/usr/share/man:\$MANPATH"
    export INFOPATH="\$HOME/usr/share/info:\$INFOPATH"
    export HOMEBREW_CACHE=/tmp/$(whoami)/Homebrew/Cache
    export HOMEBREW_LOGS=/tmp/$(whoami)/Homeberw/Logs
    if which hub > /dev/null; then eval "\$(hub alias -s)"; fi
    [[ -s \$(brew --prefix)/etc/autojump.sh ]] && . \$(brew --prefix)/etc/autojump.sh
    [[ -d "\$HOMEBREW_LOGS" ]] || mkdir -p "\$HOMEBREW_LOGS"
    [[ -d "\$HOMEBREW_CACHE" ]] || mkdir -p "\$HOMEBREW_CACHE"
EOS
    else
        oh1 "Found oh-my-zsh, skip install."
    fi
else
    ohai "Install oh-my-zsh"
    pushd "$HOME"
    git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
    cat > "$HOME/.zshrc" << EOS
export ZSH=\$HOME/.oh-my-zsh
ZSH_THEME="avit"

PATH="/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:$PATH"
export PATH="\$HOME/usr/bin:\$PATH"
export MANPATH="\$HOME/usr/share/man:$MANPATH"
export INFOPATH="\$HOME/usr/share/info:$INFOPATH"
export HOMEBREW_CACHE=/tmp/$(whoami)/Homebrew/Cache
export HOMEBREW_LOGS=/tmp/$(whoami)/Homeberw/Logs

plugins=(git git-hubflow dirhistory colored-man)

if which hub > /dev/null; then eval "\$(hub alias -s)"; fi
[[ -s \$(brew --prefix)/etc/autojump.sh ]] && . \$(brew --prefix)/etc/autojump.sh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_PATH="\$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -s "\$ZSH_HIGHLIGHT_PATH" ]] && . \$ZSH_HIGHLIGHT_PATH
[[ -d "\$HOMEBREW_LOGS" ]] || mkdir -p "\$HOMEBREW_LOGS"
[[ -d "\$HOMEBREW_CACHE" ]] || mkdir -p "\$HOMEBREW_CACHE"

source \$ZSH/oh-my-zsh.sh

clean_hist(){
    rm -f "\$HOME/.zsh_history"
}
EOS
    cat > "$HOME/usr/bin/sh" <<EOS
#!/bin/sh
if [[ -x \$HOME/usr/bin/zsh ]] && [[ \$(uname -m) == 'x86_64' ]]; then
    \$HOME/usr/bin/zsh \$*
else
    /bin/bash \$*
fi
EOS
    chmod a+x "$HOME/usr/bin/sh"
cat <<EOS
In order to use zsh as default shell, add \`command="\$HOME/usr/bin/zsh"\`
into file ~/.ssh/authorized_keys. It should look like this:

    command="\$HOME/usr/bin/sh"  ssh-rsa AAA<rest of your public key> <your email>
EOS
    popd
fi

cd "$HOME"
ohai "Done!"
