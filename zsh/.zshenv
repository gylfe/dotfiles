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

  #homebrew
  PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin
  #vim
  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

  # zsh
  export PATH=${HOME}/bin:${PATH}
  export PATH=${HOME}/.zsh/bin:${PATH}
  export FPATH=${HOME}/.zsh/func:${FPATH}

  # perl
  export PERLBREW_ROOT=${HOME}/usr/bin/perlbrew
  export PERLBREW_HOME=${HOME}/usr/bin/perlbrew
  export PERL_CPANM_OPT="--local-lib=${HOME}/usr/lib/cpanm"
  source ${HOME}/usr/bin/perlbrew/etc/bashrc
  export PATH=${HOME}/usr/lib/cpanm/bin:${PATH}
  export PERL5LIB=${HOME}/usr/lib/cpanm/lib/perl5:${HOME}/usr/lib/cpanm/lib/perl5/darwin-thread-multi-2level:${PERL5LIB}

  # ruby
  export RUBYOPT=rubygems
  if [ -d ${HOME}/usr/bin/rbenv ]; then
    export PATH=${HOME}/usr/bin/rbenv/shims:${PATH}
    eval   "$(rbenv init - zsh)"
    source /usr/local/opt/rbenv/completions/rbenv.zsh
    export CONFIGURE_OPTS="--enable-shared --with-readline-dir=/usr/local --with-openssl-dir=/usr/local"
  fi

  # node.js
  if [[ -d ${HOME}/usr/bin/nodebrew ]]; then
    export NODEBREW_ROOT=${HOME}/usr/bin/nodebrew
    export PATH=${NODEBREW_ROOT}/current/bin:${PATH}
    source <(npm completion)
    nodebrew use default >/dev/null
  fi

  # Haskell - cabal
  export PATH=${HOME}/.cabal/bin:${PATH}

  # Autoload
  autoload zargs

  typeset -U path cdpath fpath manpath

;;
esac

