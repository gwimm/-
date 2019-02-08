# bash

for util in "cp" "ln" "rm" "mv" "rename" "mkdir" "chmod" "chown"; do
	alias "${util}"="${util} -v"
done; unset util

alias :q="exit"
alias ptpb="curl -F c=@- https://ptpb.pw/"

alias l="exa"
alias la="exa --all"
alias ls="l \
	--long --bytes --git --extended --group"
alias lsa="ls --all"

alias sc="sc-im"
alias wget="wget --hsts-file=${XDG_DATA_HOME}/wget/hist"
alias irc="weechat --dir ${CFG}/weechat"
alias rss="newsboat \
	--config-file=${CFG}/newsboat/conf \
	--url-file=${CFG}/newsboat/urls"
alias tr="tremc --config=${CFG}/tremc/tremc.conf"
alias tmux="tmux -f ${CFG}/tmux/tmux.conf"

alias appear="sudo emerge"
alias unlimbo="sudo emerge -uNd @world"

alias e="${EDITOR}"
alias eerc="${EDITOR} ${editor_config}"
alias eterm="${EDITOR} ~/.config/alacritty/alacritty.yml"

alias man="extra::silent man"

eshrc() {
	case "$0" in
		*bash) ${EDITOR} ~/.bashrc;;
		*zsh) ${EDITOR} ~/.zshrc;;
		*sh|*dash) ${EDITOR} ~/.shellrc;;
	esac
}

sauce() {
	case "$0" in
		*bash) source ~/.bashrc;;
		*zsh) source ~/.zshrc;;
		*sh|*dash) source ~/.shellrc;;
	esac
}

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

	${HOME}/bin/src/ranger/ranger.py \
		--cachedir=${XDG_CACHE_HOME}/ranger \
		--datadir=${XDG_DATA_HOME}/ranger \
		--confdir="${CFG}/ranger" \
		"$@"
}
