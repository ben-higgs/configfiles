# vim: set foldmethod=marker foldlevel=0 :
#
#                   .__
#    ________  _____|  |_________   ____
#    \___   / /  ___/  |  \_  __ \_/ ___\
#     /    /  \___ \|   Y  \  | \/\  \___
# /\ /_____ \/____  >___|  /__|    \___  >
# \/       \/     \/     \/            \/
#

# {{{ ~~~ Environment ~~~

# Return if not interactive
[ -z "$PS1" ] && return

# -- System Environment --
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export EDITOR=nvim
export PAGER=less

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Security
export GPG_TTY=$(tty)

# -- Dev Environment --
# For dev tools setup (poetry, pyenv, nvm etc.) see: ~/.zprofile

#export PATH=/usr/local/aws-cli/aws:$PATH  # Dont use aws shim
#export NNN_OPENER=nuke

# Python - https://www.python.org/
eval "$(pyenv init -)"
export PYTHONPATH=.
export HYPOTHESIS_PROFILE=default

# NodeJS - https://nodejs.org/en/
# NVM - https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm (--no-use makes it lazy)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ASDF version manager - https://asdf-vm.com/
. $HOME/.asdf/asdf.sh

# Jump - https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# Terraform - https://www.terraform.io/
# For using development account (if not set it may try to deploy to prod)
export AXO373_STAGE=bhi
export TF_VAR_dev_deploy_use1=1
export TF_VAR_dev_deploy_euw2=0
#export TF_VAR_dev_deploy_euc1=0

# AWS
export AWS_REGION=us-east-1
#export AWS_REGION=eu-west-2
export AWS_PROFILE=default
export SAM_CLI_TELEMETRY=0
export SHOW_AWS_PROMPT=false # aws zsh plugin

# Buku
export BUKUSERVER_PER_PAGE=100

# }}}

# {{{ ~~~ Secrets ~~~

# Ope, no secrets here...

# }}}

# {{{ ~~~ ZSH ~~~

setopt interactive_comments

export UPDATE_ZSH_DAYS=14

# Completions
fpath+=~/.zfunc

ZSH_THEME="oxide"

HISTSIZE=500000
DISABLE_CORRECTION="true"
CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Useful when pasting large amount of text in the terminal,
# to avoid triggering autosuggestion for strings that are too long.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Set terminal title to current directory basename
precmd () {
    if [ "$PWD" = "$HOME" ]; then
        print -Pn "\e]0;~\a"
    else
        print -Pn  "\e]0;$(basename $PWD)\a"
    fi
}

plugins=(
    #asdf  # messes with pyenv path (~/.local/bin before pyenv)
    aws
    colored-man-pages
    docker
    docker-compose
    fd
    git
    pip
    #poetry
    python
    taskwarrior
    terraform
    zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
    zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
    zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# }}}

# {{{ ~~~ Aliases ~~~

# Aliased to git merge in zsh plugins. Conflics with graphics magick
unalias gm

EXA_OPTS=(--group-directories-first --group --icons --colour=always --colour-scale)
EXA_IGNORES="--ignore-glob='__pycache__|node_modules|packages'"

alias .="source"
alias ls="exa $EXA_OPTS"
alias la="exa --all $EXA_OPTS"
alias l="exa --long $EXA_OPTS $EXA_IGNORES"
alias ll="exa --long --all $EXA_OPTS $EXA_IGNORES"
alias lt="exa --long --tree $EXA_OPTS $EXA_IGNORES"
alias cll="clear && exa --long $EXA_OPTS $EXA_IGNORES"

# https://neovim.io/
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vf='nvim $(fzf)'                                  # Fuzzy find a file, then open it in vim

alias kitten='kitty +kitten'

alias zshrc="$EDITOR ~/.zshrc"
alias vimrc="$EDITOR ~/.config/nvim/init.vim"

alias py='python3'
alias ipy='ipython'
alias pe='pyenv'
alias po='poetry'
alias pip='python3 -m pip'
alias pup='python3 -m pip install --upgrade pip'
alias venv='python3 -m venv'
alias lint='black --check . && flake8 .'

CTAGS_OPTS=(--recurse -f .tags --exclude=.venv)
alias pytags="ctags $CTAGS_OPTS ."
alias tftags="ctags $CTAGS_OPTS --exclude='*' --exclude-exception='*.tf' ."

alias awsdev='aws --profile=dev'
alias ab='archivebox'
alias b='buku --np --suggest'
alias bb='b -p --np | bat -p'                           # buku browse
alias bz1='firefox $(buku -p -f 40 | fzf | cut -f1)'    # buku fzf
alias bz='firefox $(buku -p -f 10 | fzf)'               # buku fzf
alias bt='bluetoothctl'
alias cloc='cloc --exclude-dir="__pycache__",".venv"'
alias fat="fzf --preview 'bat {-1} --color=always'"     # Fzf bAT interactive file previews
alias hz='history | fzf'
alias keepass='keepassxc-cli'
#alias btop='bpytop'                                     # https://github.com/aristocratos/bpytop
#alias dkr='docker'
#alias xopen='xdg-open'

# Use 'date' for a fully formatted version      # Fri 10 Jan 2020 11:48:28 GMT
alias datestr='date "+%Y-%m-%d"'                # 2020-01-10
alias datetime='date "+%Y-%m-%d_%H:%M:%S"'      # 2020-01-10_11:49:10

# awk shortcuts
alias awk1="awk '{print \$1}'"
alias awk2="awk '{print \$2}'"
alias awk3="awk '{print \$3}'"
alias awk4="awk '{print \$4}'"
alias awk5="awk '{print \$5}'"
alias awk6="awk '{print \$6}'"

# }}}

# {{{ ~~~ Functions ~~~

# Git diff with fzf file list and preview
#gd-fzf() {
#    git diff $@ --name-only | fzf -m --ansi --preview "git diff $@ --color=always -- {-1}"
#}

function cdir() { mkdir -p "$1" && cd "$1" }

function hexd() { hexyl "$@" | less -F }

# 'Git Update Branch' - Update master and merge current branch with it
function git-update-branch() {
    CURRENT=$(git branch --show-current)
    git checkout master && git pull && git checkout $CURRENT && git merge master
}

# Delete all merged branches that dont match the regex
function git-cleanbranches() {
    git branch --merged | egrep -v "(^\*|master|staging)" | xargs git branch -d
}

# Send a desktop notification when a long running job completes
# `long-job args ...; notify`
function notify() {
    notify-send -u normal "Shell task complete"
}

# Display commands that are used often
function common-commands() {
    LINES="$1"
    FILE="${2:-$HOME/.zsh_history}"
    awk -F ';' '{print $2}' $FILE | awk '{print $1}' | sort | uniq -c | sort -g | tail -n $LINES
}

#
# Python specific functions
#
VENV_DIR=".venv"

function activate() {
    # only deactivate if different env is active
    #[[ -z ${VIRTUAL_ENV+x} ]] && [[ $(dirname $VIRTUAL_ENV) != $(pwd) ]] && deactivate

    if ! [[ -d "$VENV_DIR/" ]]; then
        echo ">>> No $VENV_DIR not found, creating..."
        python -m venv $VENV_DIR && source $VENV_DIR/bin/activate

        echo ">>> Upgrading pip"
        python -m pip install --upgrade pip

        for REQ in requirements*.txt; do
            echo
            echo ">>> Installing $REQ"
            echo
            python -m pip install -r $REQ
        done

        python -m pip install pdbpp
    fi
    source .venv/bin/activate
}

function pip-update-requirements() {
    REQUIREMENTS=${1-requirements.txt}

    [[ ! -d "$VENV_DIR/" ]] && echo ">>> No $VENV_DIR found, Creating" && python -m venv $VENV_DIR
    [[ -z ${VIRTUAL_ENV+x} ]] && echo ">>> Activating venv" && source $VENV_DIR/bin/activate

    echo ">>> Upgrading pip"
    python -m pip install --upgrade pip

    echo ">>> Updating packages in $REQUIREMENTS"
    for PKG in $(awk -F '==' '{print $1}' $REQUIREMENTS); do
        pip install --upgrade $PKG
        VERSION=$(pip show $PKG | awk '/Version:/ {print $2}')
        echo "${PKG}==${VERSION}" | tee --append /tmp/requirements_updated.txt
    done

    mv /tmp/requirements_updated.txt $REQUIREMENTS
}
alias pipur='pip-update-requirements'

function py-cleandir() {
    docker compose down
    find . -name '__pycache__' -type d -not -path "./$VENV_DIR/*" -exec rm -rv {} +
    rm -rf htmlcov/ .pytest_cache/ .coverage

    # Pass -a option to remove venv
    [[ "$1" == "-a" ]] && echo "Removing $VENV_DIR" && rm -rf "$VENV_DIR/"
}

function py-uniq-imports() {
    # TODO: extend to filter out commented lines & ignore stdlib imports
    # TODO: consolidate the 2 awk commands into one?
    rg import --no-heading | awk -F':' '/^(import|from)*/ {print $2}' \
        | awk '{print $1 " " $2}' | sort | uniq
}

# }}}
