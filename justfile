set dotenv-load

alias r := run

export EDITOR := 'nvim'

default:
  just --list

run *args:
	cabal run . {{args}}
