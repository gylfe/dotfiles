# initial setup file for both interactive and noninteractive zsh
case "${OSTYPE}" in
# Mac(Unix)
darwin*)
;;
# Linux
linux*)
export TERM=rxvt-256color
export HOME="/home/${USERNAME}"
export XAUTHORITY="${HOME}/.Xauthority"
export BROWSER="/usr/bin/luakit"
export EDITOR="/usr/bin/vim"
export MPD_HOST="${HOST}"
#export PATH=${HOME}/bin:${PATH}

# perl
export PATH=${HOME}/dict/script/perl/bin:${HOME}/.cpanm/bin:${PATH}
export PERLBREW_ROOT="${HOME}/.perlbrew"
export PERL_CPANM_OPT="--local-lib=${HOME}/.cpanm"
export PERL5LIB="${HOME}/.cpanm/lib/perl5:${HOME}/.cpanm/lib/perl5/i686-linux-thread-multi:${PERL5LIB}"
if [ -f ${HOME}/.perlbrew/etc/bashrc ]; then
	source ${HOME}/.perlbrew/etc/bashrc
fi

# Ruby
export GEM_HOME=${HOME}/.gem/ruby/1.9.1
export PATH=${HOME}/.rbenv/bin:${HOME}/.gem/ruby/1.9.1/bin:${PATH}
eval "$(rbenv init - zsh)"
source ${HOME}/.rbenv/completions/rbenv.zsh
# zsh
export PATH=${HOME}/.zsh/bin:${PATH}
export FPATH=${HOME}/.zsh/func:${FPATH}
export ZMEMO_DIR=${HOME}/dict/dropbox/code/Dropbox/docs/memo
# path
typeset -U path cdpath fpath manpath

manpath=(/usr/local/share/man(N-/)
         /usr/share/man(N-/))
;;

# Cygwin
cygwin*)

;;
esac
