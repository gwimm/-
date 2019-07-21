# bash

ps_color::fg() {
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

ps_pwd_dev() {
	while read -r; do
		set -- $REPLY
		local d="$1" mp="$2" l c ind
		[[ $PWD == $mp* ]] || continue

		c="$(ps_color::fg yellow)"
		l="$(blkid -o value -s LABEL $d)"
		ind="${1/\/dev\//}"

		[[ $l ]] && {
			ind+="[$l]"
		} || {
			ind+="[$(ps_cwd::col "${mp}" $c)]"
		}

		[[ $PWD == $mp ]] && {
			printf "${c}${ind} "
			return
		}
		printf "${c}${ind} $(ps_cwd "${PWD/${mp}\//}" $c) "
		return
	done <<< "$(<'/proc/mounts' grep -E '^/dev/sd.*')"
}

ps_cwd::slash() {
	local d p="$1"
	for d in ./*; do
		[[ -d $d ]] || continue
		p+="/"
		break
	done
	printf "$p"
}

ps_cwd::col() {
	local p="$1" c="$2"
	printf "${c}${p//\//$(ps_color::fg reset)\/${c}}"
}

ps_cwd() {
	local p="$1" c="$2"
	p="$(ps_cwd::slash "$p")"
	ps_cwd::col "$p" "$c"
}

ps_pwd() {
	in_dev=$(ps_pwd_dev)
	[[ $in_dev ]] && {
		printf "$in_dev"
		return
	}

	[[ $DIRS ]] || DIRS="/ red /"$'\n'

	while read -r; do
		set -- $REPLY
		local CWD d="$1" col="$(ps_color::fg $2)" rs="$3"
		case "$PWD" in
			$d)
				printf "${col}${rs} "
				return
				;;
			$d*)
				CWD+="${PWD/$d/$rs}"
				printf "$(ps_cwd "$CWD" $col) "
				return
				;;
		esac
	done <<< "$DIRS"
}

ps_vcs() {
	if git diff --shortstat HEAD &>/dev/null; then
		[[ $(git diff --shortstat HEAD 2>/dev/null) ]] && {
			printf "$(ps_color::fg red)± "
			return
		}
		printf "± "
	fi
}

ps_battery() {
	local col cap bat stat
	bat="/sys/class/power_supply/BAT1"
	cap="$(< ${bat}/capacity)"
	stat="$(< ${bat}/status)"

	case "$stat" in
		Full|Unknown) return ;;
		Discharging) col=$(ps_color::fg red) ;;
		Charging) col=$(ps_color::fg green) ;;
	esac
	printf "${col}${cap} "
}

ps_exit() {
	local ind="!"
	case "$EXIT_CODE" in
		0) return ;;
		1) ;;
		*) ind="$EXIT_CODE${ind}"
	esac
	printf "$(ps_color::fg red)${ind} "
}

ps_init() {
	EXIT_CODE="$?"
	unset PS1; for component in "battery" "exit" "pwd" "vcs"; {
        PS1+="$(ps_$component)$(ps_color::fg reset)"
    }
    PS1+="> "
}

DIRS+="$HOME/ green ~/"$'\n'
DIRS+="$HOME green ~"$'\n'
DIRS+="/ red /"$'\n'

PROMPT_COMMAND=ps_init
