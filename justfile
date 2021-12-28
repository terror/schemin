set dotenv-load

alias r := run
alias f := fmt

export EDITOR := 'nvim'

all: fmt-check lint forbid

default:
  just --list

run *args:
	cabal run . {{args}}

fmt:
	ormolu --mode inplace $(fd --glob *.hs)

fmt-check:
	ormolu --mode check $(fd --glob *.hs)
	@echo formatting check done

lint:
	hlint .

forbid:
	./bin/forbid

dev-deps:
	brew install hlint ormolu
