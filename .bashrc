# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

exitstatus() {
    if [[ $? == 0 ]]; then
        str='`tput setaf 46`󰸞 ';
    else
        str='`tput setaf 196` ';
    fi;

    str+=`tput sgr0`;
    eval echo -n $str;
}



PS1='$(exitstatus)[\u \W]\$ '

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

# vi keybindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'


# start tmux
if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then exec tmux; fi
