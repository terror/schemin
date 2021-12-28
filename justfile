set dotenv-load

alias r := run

export EDITOR := 'nvim'

default:
  just --list

run *args:
	cabal run . {{args}}

fmt:
	ormolu --mode inplace $(fd --glob *.hs)

fmt-check:
	ormolu --mode check $(fd --glob *.hs)
