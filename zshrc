# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Path using by homebrew
export PATH="/usr/local/sbin:$PATH"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

export TERM="xterm-256color"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
# To use fzf in zsh
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Vi mode
# bindkey -v

# the font i like
# brew cask install font-sourcecodepro-nerd-font

# make sure brew installed in macOS
if [[ "$(uname)" == "Darwin" ]]; then
    if ! [ -x "$(command -v brew)" ]; then
        xcode-select --install
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew doctor
        brew install caskroom/cask/brew-cask
    fi
fi

# install nvim 
if [[ "$(uname)" == "Darwin" ]]; then
    if ! [ -x "$(command -v nvim)" ]; then
    	unlink /usr/local/bin/python
    	ln -s /usr/local/bin/python3 /usr/local/bin/python
    	pip3 install neovim --upgrade
    	brew install neovim/neovim/neovim
    fi
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    if ! [ -x "$(command -v nvim)" ]; then
        sudo apt install neovim
        sudo apt install python3-neovim
    fi
fi

# psql app into cli
if [[ "$(uname)" == "Darwin" ]]; then
    if [ -e /Applications/MySQLWorkbench.app/Contents/MacOS ]; then
        export PATH=$PATH:/Applications/MySQLWorkbench.app/Contents/MacOS
    fi
fi

# rust
if ! [ -x "$(command -v rustup)" ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

# rust cargo export
export PATH="$HOME/.cargo/bin:$PATH"

# GPG sign into cli
export GPG_TTY=$(tty)

if [[ "$(uname)" == "Darwin" ]]; then
    # bat a better cat
    if ! [ -x "$(command -v bat)" ]; then
        brew install bat
    fi

    # exa a better ls
    if ! [ -x "$(command -v exa)" ]; then
        brew install exa
    fi
    
    # fd a better find
    if ! [ -x "$(command -v fd)" ]; then
        brew install fd
    fi
    
    # rg ripgrep
    if ! [ -x "$(command -v rg)" ]; then
        brew install ripgrep
    fi
    
    # sd better sed
    if ! [ -x "$(command -v sd)" ]; then
    	brew install sd
    fi
    
    # asciinema
    if ! [ -x "$(command -v asciinema)" ]; then
        brew install asciinema
    fi
    
    # grip (for GitHub flavoured markdown)
    if ! [ -x "$(command -v grip)" ]; then
    	brew install grip
    fi
    
    # markdown
    if ! [ -x "$(command -v markdown)" ]; then
    	brew install markdown
    fi
    
    # zsh-syntax-highlighting
    if ! [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    	brew install zsh-syntax-highlighting
    fi
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    
    # zsh-autosuggestions
    if ! [ -e /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] ; then
    	brew install zsh-autosuggestions
    fi
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    
    # ctags
    if ! [ -x "$(command -v ctags)" ]; then
    	brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    fi
    
    if ! [ -e $ZSH_CUSTOM/themes/powerlevel10k ]; then
    	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    fi
    
    # fzf
    if ! [ -x "$(command -v fzf)" ]; then
    	brew install fzf
    	$(brew --prefix)/opt/fzf/install
    fi

elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then

    # ctags
    if ! [ -x "$(command -v ctags)" ]; then
	sudo apt install automake autoconf pkg-config make build-essential
	pushd /tmp/
	git clone https://github.com/universal-ctags/ctags.git
	pushd ctags
	./autogen.sh
	./configure
	make
	sudo make install
	popd
	popd

	location="$(which ctags)"
	version="$(ctags --version)"
	echo "ctags binary location: $location and version: $version"
    fi

    # jq (this one needs to be install first, since the rest of tools are counting on it)
    if ! [ -x "$(command -v jq)" ]; then
	pushd /tmp/
	curl -s https://api.github.com/repos/stedolan/jq/releases/latest \
	| grep "browser_download_url.*jq-linux64" \
	| cut -d ":" -f 2,3 \
	| tr -d \" \
	| wget -qi -
	
	chmod +x jq-linux64	
	sudo mv jq-linux64 /usr/local/bin/jq
	popd

	location="$(which jq)"
	version="$(jq --version)"
	echo "jq binary location: $location and version: $version"
    fi

    # bat a better cat
    if ! [ -x "$(command -v bat)" ]; then
	pushd /tmp/
	curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
	| jq -r '.assets[] | select(.name | contains("x86_64-unknown-linux-gnu.tar.gz")) | .browser_download_url' \
	| wget -i -
	
	tarball="$(find . -name "bat-*-x86_64-unknown-linux-gnu.tar.gz")"
	folball="bat_folder"
	mkdir $folball && tar -xzf $tarball -C $folball --strip-components 1
	chmod +x $folball/bat
	sudo mv $folball/bat /usr/local/bin/bat
	popd

	location="$(which bat)"
	version="$(bat --version)"
	echo "bat binary location: $location and version: $version"
    fi

    # exa a better ls
    if ! [ -x "$(command -v exa)" ]; then
        pushd /tmp/
	curl -s https://api.github.com/repos/ogham/exa/releases/latest \
	| jq -r '.assets[] | select(.name | contains("linux-x86_64")) | .browser_download_url' \
	| wget -i -
	
	tarball="$(find . -name "*-linux-x86_64-*")"
	folball="bat_folder"
	unzip -p $tarball > exa 
	chmod +x exa
	sudo mv exa /usr/local/bin/exa
	popd

	location="$(which exa)"
	version="$(exa --version)"
	echo "exa binary location: $location and version: $version"
    fi
    
    # fd a better find
    if ! [ -x "$(command -v fd)" ]; then
	pushd /tmp/
	curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
	| jq -r '.assets[] | select(.name | contains("-x86_64-unknown-linux-gnu.tar.gz")) | .browser_download_url' \
	| wget -i -
	
	tarball="$(find . -name "fd-*-x86_64-unknown-linux-gnu.tar.gz")"
	folball="fd_folder"
	mkdir $folball && tar -xzf $tarball -C $folball --strip-components 1
	chmod +x $folball/fd
	sudo mv $folball/fd /usr/local/bin/fd
	popd

	location="$(which fd)"
	version="$(fd --version)"
	echo "fd binary location: $location and version: $version"
    fi
    
    # rg ripgrep
    if ! [ -x "$(command -v rg)" ]; then
	pushd /tmp/
	curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
	| jq -r '.assets[] | select(.name | contains("-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
	| wget -i -
	
	tarball="$(find . -name "ripgrep-*-x86_64-unknown-linux-musl.tar.gz")"
	folball="rg_folder"
	mkdir $folball && tar -xzf $tarball -C $folball --strip-components 1
	chmod +x $folball/rg
	sudo mv $folball/rg /usr/local/bin/rg
	popd

	location="$(which rg)"
	version="$(rg --version)"
	echo "rg binary location: $location and version: $version"
    fi
    
    # sd better sed
    if ! [ -x "$(command -v sd)" ]; then
	pushd /tmp/
	curl -s https://api.github.com/repos/chmln/sd/releases/latest \
	| jq -r '.assets[] | select(.name | contains("-x86_64-unknown-linux-gnu")) | .browser_download_url' \
	| wget -i -
	
	tarball="$(find . -name "sd-*-x86_64-unknown-linux-gnu")"
	chmod +x $tarball
	sudo mv $tarball /usr/local/bin/sd
	popd

	location="$(which sd)"
	version="$(sd --version)"
	echo "sd binary location: $location and version: $version"
    fi

    # zsh-syntax-highlighting
    if ! [ -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
    
    # zsh-autosuggestions
    if ! [ -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ] ; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    # fzf
    if ! [ -x "$(command -v fzf)" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
    fi
fi

# fzf zsh config
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --layout=reverse --inline-info'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type d . --color=never"
export FZF_ALT_C_OPTS="--preview 'exa --tree --all --color=always --color-scale {}'"

# ffe find the file then edit
ffe() {
    local file=$(
      fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
      )
    if [[ -n $file ]]; then
        $EDITOR $file
    fi
}

# fge - find the content in files
fge(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR $file +$(echo "$match" | cut -d':' -f2)
    fi
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# commands mapping
alias ear="exa --recurse"
alias ea="exa"
alias asciirec="asciinema rec"
alias nv="nvim"

# if [ "$TMUX" = "" ]; then tmux; fi

