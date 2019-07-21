# environment
DOT="${HOME}/dot"
CFG="${DOT}/cfg"

PAGER="cat"
MANPAGER="less"
LESSHISTFILE="/dev/null"

editor_config="${CFG}/neovim/config.vim"
EDITOR="nvim -u ${editor_config}"
VISUAL="${EDITOR}"

# xdg
XDG_DATA_HOME="${HOME}/.local/share"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DESKTOP_DIR="/dev/null"

# prefixes
PREFIX_DATA="${XDG_DATA_HOME}"

# shell
INPUTRC="${CFG}/bash/inputrc"
HISTFILE="${XDG_CACHE_HOME}/shell_history"
HISTSIZE=10000

# pulseaudio
PULSE_COOKIE="${PREFIX_DATA}/pulse/cookie"

# ocaml
OPAMROOT="${PREFIX_DATA}/opam"

# go
GOPATH="${PREFIX_DATA}/go"

# rust
CARGO_HOME="${PREFIX_DATA}/cargo"
RUSTUP_HOME="${PREFIX_DATA}/rustup"
RUST_SRC_PATH="${RUSTUP_HOME}/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# ruby
RBENV_ROOT="${PREFIX_DATA}/rbenv"

# scala
ROSWELL_HOME="${PREFIX_DATA}/roswell"

# haskell
CABAL_HOME="${PREFIX_DATA}/cabal"

# js
NODE_HOME="${PREFIX_DATA}/node"
NODENV_ROOT="${PREFIX_DATA}/nodenv"
N_PREFIX="${PREFIX_DATA}/n"

NPM_HOME="${PREFIX_DATA}/npm"

NPM_CONFIG_USERCONFIG="${CFG}/npm/npmrc"
NPM_CONFIG_GLOBALCONFIG="${CFG}/npm/npmrc"

# lua
LUAROCKS_CONFIG="${CFG}/luarocks/config.lua"
LUAROCKS_HOME="${PREFIX_DATA}/luarocks"
# LUA_PATH="${LUAROCKS_HOME}/lib/lua/5.1/?.so;;"
# LUA_CPATH="${LUAROCKS_HOME}/lib/lua/5.1/?.so;;"

# python stuff
PYENV_ROOT="${PREFIX_DATA}/pyenv"
PIPSI_HOME="${PREFIX_DATA}/pipsi/venvs"
PIPSI_BIN_DIR="${PREFIX_DATA}/pipsi/bin"
PYTHONUSERBASE="${PREFIX_DATA}/pip"
PYTHONPATH="${PYTHONUSERBASE}/lib64/python3.6/site-packages:${PYTHONPATH}"

PATH="\
${HOME}/bin:\
${DOT}/bin:\
${PYENV_ROOT}/bin:\
${PIPSI_BIN_DIR}:\
${NODENV_ROOT}/bin:\
${NPM_HOME}/bin:\
${PYTHONUSERBASE}/bin:\
${CARGO_HOME}/bin:\
${GOPATH}/bin:\
${NODE_HOME}/bin:\
${CABAL_HOME}/bin:\
${OPAMROOT}/default/bin:\
${LUAROCKS_HOME}/bin:\
/usr/lib64/lua/luarocks/bin:\
${PATH}"

[[ $DBUS_SESSION_BUS_ADDRESS ]] &&
	export $(dbus-launch)

export DOT CFG
export HISTFILE HISTSIZE
export VISUAL EDITOR LUAROCKS_CONFIG LUAROCKS_HOME LUA_PATH
export PAGER MANPAGER LESSHISTFILE
export XDG_CONFIG_HOME XDG_DESKTOP_DIR XDG_DATA_HOME PULSE_COOKIE
export GOPATH CARGO_HOME RUSTUP_HOME RUST_SRC_PATH ROSWELL_HOME OPAMROOT
export NODE_HOME NODENV_ROOT NPM_CONFIG_USERCONFIG NPM_CONFIG_GLOBALCONFIG
export PYENV_ROOT PYTHONUSERBASE PYTHONPATH PIPSI_HOME PIPSI_BIN_DIR
export PATH
