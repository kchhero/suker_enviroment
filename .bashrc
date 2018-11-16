# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth
HISTCONTROL=erasedups


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="[\e[33m\u\e[31m@\e[33m\h\e[32m] \e[32m\w\e[m\n\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF --block-size=K'
alias la='ls -A'
alias l='ls -CF'
alias gr='grep -n -i -r'
alias gitpatch='git diff --no-prefix > '
alias ee='env TERM=xterm-256color emacs -nw'
#alias ee='emacs -nw'

myfilefind()
{
	find . -name $1
}
alias fnf=myfilefind

myPyuicConvert()
{
	pyuic5 -x *.ui -o $1
}
alias pyc8=myPyuicConvert
	
mydirfind()
{
	find . ! \( -path './out' -prune \) -name $1 -type d
}
alias fnd=mydirfind

myfilefindgrep_c()
{
	find . -type f -name "*\.c" -print0 | xargs -0 grep --color -n $1
}
alias _grc=myfilefindgrep_c

myfilefindgrep_h()
{
	find . -type f -name "*\.h" -print0 | xargs -0 grep --color -n $1
}
alias _grh=myfilefindgrep_h

myfilefindgrep_mksh()
{
	find . -name "*\.mk" -o -name "*\.sh" -print0 | xargs -0 grep --color -n $1
}
alias _grms=myfilefindgrep_mksh

myfilefindgrep_xml()
{
	find . -type f -name "*\.xml" -print0 | xargs -0 git grep --color -n $1
}
alias _grxml=myfilefindgrep_xml

myfilefindgrep_all()
{
    find . -name '*' -type f -print0 | xargs -0 grep --color -n $1 --exclude-dir=$2
}
alias _gra=myfilefindgrep_all

mycd()
{
	cd $1 && pwd > ~/pwd
}
alias cd=mycd

gitc8()
{
    git clean -f -d;git checkout -f
}

myGitLogging()
{
    if [ -z $1 ];then
	git log --pretty=oneline
    else
	git log --pretty=oneline --grep $1
    fi
}
alias _gl=myGitLogging

myFileCountInDir()
{
    ls -R $1 | wc -l
}
alias _cntF=myFileCountInDir

mySSHID()
{
    xclip -sel clip < ~/.ssh/id_rsa.pub
}
alias _getsshid=mySSHID

whereSrc()
{
    ~/sukerScripts/arm-linux-androideabi-addr2line -e $1 $2
}
alias _ws=whereSrc

currentGoAndroidRoot()
{
    cd $(gettop)
}
alias goroot=currentGoAndroidRoot

currentGoKernelRoot()
{
    cd $(gettop)/kernel
}
alias gokernel=currentGoKernelRoot

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

currentGoBootableRoot()
{
    cd $(gettop)/bootable
}

currentGoSBL()
{
    cd $(gettop)/../non_HLOS/boot_images
}
alias gosbl=currentGoSBL

repoallclean()
{
    find . -type d -name ".git" | xargs -I {} sh -c 'cd {};cd ..;git clean -f -d;git checkout -f'
}
alias repocln=repoallclean

myGCC()
{
    ARG1=$1
    FFF=".c"
    gcc -v -o $ARG1 $ARG1$FFF
}
alias cert=myGCC

myTTYUSB0()
{
    sudo chown suker:suker /dev/ttyUSB0
    sudo chmod 755 /dev/ttyUSB0
    sed -i "/set line \/dev/d" ~/.mykermrc
    echo "set line /dev/ttyUSB0" | cat - ~/.mykermrc > kermit_temp.txt && mv kermit_temp.txt ~/.mykermrc
}
alias _usb0=myTTYUSB0

myTTYUSB1()
{
    sudo chown suker:suker /dev/ttyUSB1
    sudo chmod 755 /dev/ttyUSB1
    sed -i "/set line \/dev/d" ~/.mykermrc
    echo "set line /dev/ttyUSB1" | cat - ~/.mykermrc > kermit_temp.txt && mv kermit_temp.txt ~/.mykermrc
}
alias _usb1=myTTYUSB1

myTTYUSB2()
{
    sudo chown suker:suker /dev/ttyUSB2
    sudo chmod 755 /dev/ttyUSB2
    sed -i "/set line \/dev/d" ~/.mykermrc
    echo "set line /dev/ttyUSB2" | cat - ~/.mykermrc > kermit_temp.txt && mv kermit_temp.txt ~/.mykermrc
}
alias _usb2=myTTYUSB2

myTTYS0()
{
    sudo chown suker:suker /dev/ttyS0
    sudo chmod 755 /dev/ttyS0
    sed -i "/set line \/dev/d" ~/.mykermrc
    echo "set line /dev/ttyS0" | cat - ~/.mykermrc > kermit_temp.txt && mv kermit_temp.txt ~/.mykermrc
}
alias _s0=myTTYS0

# ---- suker keybinding -----
# <F8> run ~/asdf.sh
bind '"\e[19": "~/asdf.sh\n"'
bind '"\e[21": "python ~/sukerGitHub/suker_python_project/sukerStock/myFavoriteStock/stockMain.py&\n"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
alias _qu='quota -us suker'
alias _auto='python ~/sukerGitHub/sukerPython/sukerScripts/main.py'
alias _add='cd ~/sukerScripts';ls -al
alias makeEtags='find . -name "*.[chCHsS]" -print | xargs etags -a -o TAGS'
alias sw2servercon='ssh -X sw2@192.168.1.15'

export HISTCONTROL=ignoredups

export PYTHONPATH=$HOME/.emacs.d/elpa/elpy-1.14.1/
export PATH=$PATH:/opt/crosstools/gcc-linaro-4.9-2015.05-x86_64_aarch64-linux-gnu/bin
export PATH=$PATH:/opt/crosstools/gcc-linaro-aarch64-none-elf-4.8-2014.04_linux/bin/
export PATH=$PATH:/opt/crosstools/arm-cortex_a9-eabi-4.7-eglibc-2.18/bin/
export PATH=$PATH:/opt/crosstools/gcc-linaro-4.9-2015.05-x86_64_arm-linux-gnueabi/bin/
export PATH=$PATH:/opt/crosstools/arm-eabi-4.8/bin/
export PATH=$PATH:/opt/crosstools/gcc-arm-none-eabi-7-2017-q4-major/bin/
#export PATH=$PATH:/opt/poky/2.1.1/sysroots/x86_64-pokysdk-linux/usr/bin/
export PATH=$PATH:/opt/poky/2.1.2-X11/sysroots/cortexa9hf-neon-poky-linux-gnueabi/usr/bin
export PATH=$PATH:/home/suker/riscv-toolchain/bin
export PATH=$PATH:/home/suker/Qt5.10.1/5.10.1/gcc_64/bin/:/home/suker/Qt5.10.1/Tools/QtCreator/bin/

#myapp
export PATH=$PATH:~/bin

#RISCV
export RISCV=~/riscv-toolchain/bin/
export PATH=$PATH:$RISCV

#clojure
#export CLOJURE_HOME=/usr/local/clojure-1.8.0
#export CLASSPATH=$CLASSPATH:/usr/local/clojure-1.8.0

#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
#export PATH=$JAVA_HOME/bin:$PATH

#sudo mount /dev/sdb1 /home/suker/sukerSDB
#sudo mount -t cifs //SW-01/suker ~/sukerSMB -o user=suker,password=123,workgroup=WORKGROUP,ip=192.168.1.16,iocharset=utf8
#sudo mount -vt //192.168.1.16/suker ~/sukerSMB -o user=suker,pass=cndgus123 -t auto
#sudo mount.cifs -o user=suker,password=cndgus123 //192.168.1.16/suker ~/sukerSMB
