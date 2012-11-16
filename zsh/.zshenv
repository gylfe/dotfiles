# initial setup file for both interactive and noninteractive zsh
case "${OSTYPE}" in
# Linux ==========================
linux*)
    export BROWSER=/usr/bin/luakit
    export EDITOR=/usr/bin/vim
    export HOME=/home/${USERNAME}
    export MPD_HOST="${HOST}"
    export PATH=${HOME}/bin:${PATH}
    export XAUTHORITY=${HOME}/.Xauthority
    export __CF_USER_TEXT_ENCODING="0x1F5:0x08000100:14"

    # zsh
    export FPATH=${HOME}/.zsh/func:${FPATH}
    export PATH=${HOME}/.zsh/bin:${PATH}
    export ZMEMO_DIR=${HOME}/dict/dropbox/code/Dropbox/docs/memo
    export ZSHDIR=${HOME}/.zsh

    # Ruby
    # export GEM_HOME=${HOME}/.gem/ruby/1.9.3
    # export GEM_PATH=${HOME}/.gem/ruby/1.9.3/bin
    export PATH=${HOME}/.gem/ruby/1.9.1/bin:${PATH}
    export RSENSE_HOME=$HOME/.rsense
    if [ -d ${HOME}/.rbenv ]; then
        export PATH=${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}
        eval   "$(rbenv init - zsh)"
        source ${HOME}/.rbenv/completions/rbenv.zsh
        export CONFIGURE_OPTS="--enable-shared --with-readline-dir=/usr --with-openssl-dir=/usr"
    fi

    # perl
    export PATH=${HOME}/dict/script/perl/bin:${HOME}/.cpanm/bin:${PATH}
    export PERL5LIB=${HOME}/.cpanm/lib/perl5:${HOME}/.cpanm/lib/perl5/i686-linux-thread-multi:${PERL5LIB}
    export PERLBREW_ROOT=${HOME}/.perlbrew
    export PERL_CPANM_OPT="--local-lib=${HOME}/.cpanm"
    [[ -f ${HOME}/.perlbrew/etc/bashrc ]] && source ${HOME}/.perlbrew/etc/bashrc

    # node.js
    export PYTHON=python2
    [[ -s ${HOME}/.nvm/nvm.sh ]] && source ${HOME}/.nvm/nvm.sh

    # Git
    export PATH=${HOME}/git/tools/git-tasukete:${PATH}

    # Autoload
    autoload zargs

    # path
    manpath=(/usr/local/share/man(N-/)
    /usr/share/man(N-/))

    typeset -U path cdpath fpath manpath
;;
# Cygwin ==========================
cygwin*)
;;
# Mac(Unix) ==========================
darwin*)
;;
esac
