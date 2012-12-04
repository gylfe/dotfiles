# initial setup file for both interactive and noninteractive zsh
#
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
    export RUBYOPT=rubygems
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
    export PERLBREW_HOME=${HOME}/.perlbrew
    export PERL_CPANM_OPT="--local-lib=${HOME}/.cpanm"
    # export PERL_LOCAL_LIB_ROOT=${HOME}/.cpanm
    # export PERL_MB_OPT="--install_base ${HOME}/.cpanm"
    # export PERL_MM_OPT="INSTALL_BASE ${HOME}/.cpanm"
    [[ -f ${HOME}/.perlbrew/etc/bashrc ]] && source ${HOME}/.perlbrew/etc/bashrc

    # node.js
    export PYTHON=python2
    [[ -s ${HOME}/.nvm/nvm.sh ]] && source ${HOME}/.nvm/nvm.sh

    # Git
    export GISTY_DIR=${HOME}/dict/script/gists
    export PATH=${HOME}/git/tools/git-tasukete:${PATH}

    # for git tools
    export PATH=${HOME}/git/tools/mem:${PATH}
    export PATH=${HOME}/git/tools/git-hg/bin:${PATH}

    # Autoload
    autoload zargs

    # path
    # export MANPATH=/usr/local/share/man:/usr/share/man:

    typeset -U path cdpath fpath # manpath

    # [[ -f ~/.infinality ]] && source ~/.infinality
;;
# Cygwin ==========================
cygwin*)
;;
# Mac(Unix) ==========================
darwin*)
    # zsh
    export PATH=${HOME}/bin:${PATH}
    export PATH=${HOME}/.zsh/bin:${PATH}
    export FPATH=${HOME}/.zsh/func:${FPATH}

    # ruby
    export RUBYOPT=rubygems
    if [ -d ${HOME}/.rbenv ]; then
        export PATH=${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}
        eval   "$(rbenv init - zsh)"
        source /usr/local/opt/rbenv/completions/rbenv.zsh
        export CONFIGURE_OPTS="--enable-shared --with-readline-dir=/usr/local --with-openssl-dir=/usr/local"
    fi

    # node.js
    export NODEBREW_ROOT=${HOME}/.nodebrew
    export PATH=${HOME}/.nodebrew/current/bin:${PATH}
;;
esac

