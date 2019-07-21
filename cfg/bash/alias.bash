# bash

for util in "cp" "ln" "rm" "mv" "rename" "mkdir" "chmod" "chown"; {
	alias "${util}"="${util} -v"
}; unset util

alias :q="exit"
alias ptpb="curl -F c=@- https://ptpb.pw/"

alias l="exa"
alias la="exa --all"
alias ls="l --long --bytes --git --extended --group"
alias lsa="ls --all"

alias sc="sc-im"
alias wget="wget \
    --hsts-file     ${XDG_DATA_HOME}/wget/hist"

alias irc="weechat \
    --dir           ${CFG}/weechat"

alias rss="newsboat \
	--config-file   ${CFG}/newsboat/conf \
	--url-file      ${CFG}/newsboat/urls"

alias tmux="tmux -f ${CFG}/tmux/tmux.conf"

alias cabal="cabal \
    --config-file   ${CABAL_HOME}/config"

alias luarocks="luarocks \
    --local --tree=${LUAROCKS_HOME}"

alias appear="sudo emerge"
alias unlimbo="appear -uNd @world"

get_rc() {
	case "$0" in
		*bash) echo "~/.bashrc";;
		*zsh) echo "~/.zshrc";;
		*sh|*dash) echo "~/.shellrc";;
	esac
}

alias sauce=". $(get_rc)"

alias e="${EDITOR}"
alias esh="e $(get_rc)"
alias eerc="e ${editor_config}"
alias eterm="e ~/.config/alacritty/alacritty.yml"

lf() {
	case "$1" in
		-f|--force) shift ;;
		*)
			[[ $RANGER_LEVEL ]] && {
				echo "already in a ranger shell, master..."
				echo "RANGER_LEVEL: ${RANGER_LEVEL}"
				return 1
			}
			;;
	esac

	${HOME}/src/ranger%ranger/ranger.py \
		--cachedir=${XDG_CACHE_HOME}/ranger \
		--datadir=${XDG_DATA_HOME}/ranger \
		--confdir="${CFG}/ranger" \
		"$@"
}
