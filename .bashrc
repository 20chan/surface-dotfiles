#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

alias vi='vim'

export PATH=/home/chan/.gem/ruby/2.6.0/bin/:$PATH
PATH="/home/chan/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/chan/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/chan/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/chan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/chan/perl5"; export PERL_MM_OPT;

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
