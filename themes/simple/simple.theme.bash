#!/usr/bin/env bash

# prompt themeing

#added TITLEBAR for updating the tab and window titles with the pwd
case $TERM in
	xterm*)
	TITLEBAR="\[\033]0;\j\007\]"
	;;
	*)
	TITLEBAR=""
	;;
esac

function prompt_command() {
  split_char='/'
  current_full=`pwd`
  current_base="${current_full##*${split_char}}"
  parent_full=$(dirname $current_full)

  if [ $parent_full == '/' ] && [ `pwd` == '/' ]; then
    parent="${bold_yellow}/"
  elif [ $parent_full == '/' ]; then
    parent="/${bold_yellow}$current_base"
  else
    parent_base="${parent_full##*${split_char}}"
    parent="${reset_color}$parent_base/${bold_yellow}$current_base"
  fi
	PS1="${TITLEBAR}${orange}${reset_color}$parent ${bold_blue}\[$(scm_prompt_info)\]${normal} \n> "
}

# scm themeing
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

safe_append_prompt_command prompt_command
