#!/bin/bash

ip="/tmp/ncmpcpp/cover.png"

main() {
	case $1 in
		start) dmon:start $ip && exit;;
	esac

	mpd_pt=$(mpd:cur)

	ipct=$(img:fmpdt "$mpd_pt")

	if [[ -n $ipct ]]; then
		cp "$ipct" "$ip"
		# convert "$ipct" -resize 1000x1000\< "$ip"
	else
		convert -size 0x0 xc:none "$ip"
	fi
}

## get path to the cover.*
## faudio(mpd:pa) -> ipc
img:fmpdt() {
	local p mpd_pt=$1
	p=$(find "${mpd_pt%/*}" -maxdepth 1 -name "cover.*")
	[[ -n $p ]] &&
		echo -En $p && return
}

## get path to the current track
## cur() -> ic
mpd:cur() {
	local dm icr
	dm=$(awk '/^music_dir/{gsub("\"",""); print $2}' /etc/mpd.conf)
	icr=$(mpc --format %file% current)
	echo -En $dm/$icr
}

## pipe to ueberzug
## img:ud()
img:pipe() {
    ueberzug layer -sp bash
}

## add image
## img:add()
img:upd() {
	cols=$(tput cols)
	lins=$(tput lines)
	y=2
	w=$(($cols / 2))

	[[ $(($w / 2)) > $(($lins - $y)) ]] &&
		w=$(( $(($lins * 2)) - 3 ))

	x=$(($cols - $w))

	cat<<EOF
declare -A data=([path]="/tmp/ncmpcpp/cover.png" \
[action]="add" [max_width]="$w" \
[identifier]="img" [y]="$y" [x]="$x" )"
EOF
}

dmon:start() {
	mkdir -p /tmp/ncmpcpp
	touch /tmp/ncmpcpp/cover.png
	img:pipe -< <(
		while :;do
			img:upd
			inotifywait -q -q -e close_write "$ip"
		done
	)
}

main $@
