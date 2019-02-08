# bash

prompt::color::fg() {
	local esc_open="\[" esc_close="\]" col=$1
	case "$col" in
		black|none|NONE) col=0 ;;
		red) col=1 ;;
		green) col=2 ;;
		yellow) col=3 ;;
		blue) col=4 ;;
		magenta) col=5 ;;
		cyan) col=6 ;;
		reset|white) col=7 ;;
	esac
	printf "${esc_open}\\e[3${col}m${esc_close}"
}



prompt::pwd::dev() {
	while read -r; do
		set -- $REPLY
		local d="$1" mp="$2" l c ind
		[[ $PWD == $mp* ]] || continue

		c="$(prompt::color::fg yellow)"
		l="$(blkid -o value -s LABEL $d)"
		ind="${1/\/dev\//}"

		[[ $l ]] && {
			ind+="[$l]"
		} || {
			ind+="[$(prompt::cwd::col "${mp}" $c)]"
		}

		[[ $PWD == $mp ]] && {
			printf "${c}${ind} "
			return
		}
		printf "${c}${ind} $(prompt::cwd "${PWD/${mp}\//}" $c) "
		return
	done <<< "$(<'/proc/mounts' grep -Ee'^/dev/sd.*')"
}

## slash(p) -> p
prompt::cwd::slash() {
	local d p="$1"
	for d in ./*; do
		[[ -d $d ]] || continue
		p+="/"
		break
	done
	printf "$p"
}

## col(p, c) -> c
prompt::cwd::col() {
	local p="$1" c="$2"
	printf "${c}${p//\//$(prompt::color::fg reset)\/${c}}"
}

prompt::cwd() {
	local p="$1" c="$2"
	p="$(prompt::cwd::slash "$p")"
	prompt::cwd::col "$p" "$c"
}

prompt::pwd() {
	in_dev=$(prompt::pwd::dev)
	[[ $in_dev ]] && {
		printf "$in_dev"
		return
	}

	[[ $DIRS ]] || DIRS="/ red /"$'\n'

	while read -r; do
		set -- $REPLY
		local CWD d="$1" col="$(prompt::color::fg $2)" rs="$3"
		case "$PWD" in
			$d)
				printf "${col}${rs} "
				return
				;;
			$d*)
				CWD+="${PWD/$d/$rs}"
				printf "$(prompt::cwd "$CWD" $col) "
				return
				;;
		esac
	done <<< "$DIRS"
}

prompt::vcs::git() {
	if git diff --shortstat HEAD &>/dev/null; then
		[[ $(git diff --shortstat HEAD 2>/dev/null) ]] && {
			printf "$(prompt::color::fg red)± "
			return
		}
		printf "± "
	fi
}

prompt::battery() {
	local col cap bat stat
	bat="/sys/class/power_supply/BAT1"
	cap="$(< ${bat}/capacity)"
	stat="$(< ${bat}/status)"

	case "$stat" in
		Full|Unknown) return ;;
		Discharging) col=$(prompt::color::fg red) ;;
		Charging) col=$(prompt::color::fg green) ;;
	esac
	printf "${col}${cap} "
}

prompt::exitstat() {
	local ind="!"
	case "$EXIT_CODE" in
		0) return ;;
		1) ;;
		*) ind="$EXIT_CODE${ind}"
	esac
	printf "$(prompt::color::fg red)${ind} "
}

prompt::rprompt() {
	printf "%*s" $COLUMNS "right prompt"
}

prompt::constructor() { 
	EXIT_CODE="$?" # i really don't want to do this first though q-q
	unset PS1
	for ps in "$(prompt::battery)" "$(prompt::exitstat)" "$(prompt::pwd)" \
			  "$(prompt::vcs::git)" "> "; do
		PS1+="${ps}$(prompt::color::fg reset)"
	done
}

DIRS+="$HOME/ green ~/"$'\n'
DIRS+="$HOME green ~"$'\n'
DIRS+="/ red /"$'\n'

PROMPT_COMMAND=prompt::constructor
