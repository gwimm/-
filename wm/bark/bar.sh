#!/bin/bash

. '/sai/bin/src/bashdl/src/lib.sh'

main() {
	bar
}

cleanup() {
	pkill -P "$$"
	rm "$FIFO"
	bspc config top_padding "$(sl:s:mw 'top_padding' 4 <'/sai/dot/wm/bark/bspwmrc')"
	echo $@
}

trap "cleanup $@" EXIT

BARWIDTH=35
FONT="scientifica:style=bold"
FIFO=$(mktemp -u)
mkfifo "$FIFO"

gap="$(sl:s:mw 'window_gap' 4 <'/sai/dot/wm/bark/bspwmrc')"
left_padding="$(( "$(sl:s:mw 'left_padding' 4 <'/sai/dot/wm/bark/bspwmrc')" + gap ))"
right_padding="$(( "$(sl:s:mw 'right_padding' 4 <'/sai/dot/wm/bark/bspwmrc')" + gap ))"
top_padding="$(( "$(sl:s:mw 'top_padding' 4 <'/sai/dot/wm/bark/bspwmrc')" + gap ))"
bottom_padding="$(( "$(sl:s:mw 'bottom_padding' 4 <'/sai/dot/wm/bark/bspwmrc')" + gap ))"

bc="$(sl:s:mw 'normal_border_color' 4 <'/sai/dot/wm/bark/bspwmrc' | sl:s:rm "'" )"
wb="$(sl:s:mw 'border_width' 4 <'/sai/dot/wm/bark/bspwmrc')"

res="$(xrandr | sl:s:mw '*' 1)"

wx="$(echo $res | cut -f 1 -d 'x')"
wy="$(echo $res | cut -f 2 -d 'x')"

geometry="$((wx - left_padding - right_padding))x${BARWIDTH}+${left_padding}+${top_padding}"
_geometry="$((wx - left_padding - right_padding - $((wb * 2)) ))x$((BARWIDTH - $((wb * 2)) ))+$((left_padding + wb))+$((top_padding + wb))"

font() {
	local fv=(
	'scientifica'
	'IPAGothic:antialias=false:size=8'
	)

	for f in ${fv[*]}; do
		echo -En " -f $f "
	done
}

bar:time() {
	local msg="$1"
	while :; do
		echo "${msg}$(date +%H)"
    	# local binhour hour="$(date +%H)"
		# bin64=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1})

    	# binhour="${bin64["$hour"]}"
    	# binhour="${binhour//0/·}"
    	# binhour="${binhour//1/•}"

		# echo "${msg}${binhour}"
		sleep 5
	done
}

bar:bat() {
	while :; do
		echo dab
		sleep 5
	done
}

bar:mu() {
	local msg=$1
	while :; do
		echo "${msg}$(mpc current)"
		mpc idle
	done
}

bar() {
	bspc config top_padding "$(( "$(sl:s:mw 'top_padding' 4 <'/sai/dot/wm/bark/bspwmrc')" + BARWIDTH + gap))"

	bat_pfix="bat: "
	time_pfix="dat: "
	mu_pfix="mu: "

	bar:time "$time_pfix" > "$FIFO" &
	bar:bat "$bat_pfix" > "$FIFO" &
	bar:mu "$mu_pfix" > "$FIFO" &

	lemonbar -g "$geometry" -B "$bc" -p | sh &
	while read -r line; do
		case $line in
			${mu_pfix}*)
				mu="${line//${mu_pfix}/}";;
			${time_pfix}*)
				dat="${line//${time_pfix}/}";;
		esac
		echo "%{c}${mu}%{r}%{O10}${dat}"
	done < $FIFO | lemonbar -g "$_geometry" -F '#FEFEFE' -B '#101716' $(font)
}

main $@
