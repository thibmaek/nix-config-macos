.DEFAULT_GOAL := update

build:
	darwin-rebuild switch --flake ~/.config/nix

update:
	nix flake update
	nix-channel --update
	darwin-rebuild switch --flake ~/.config/nix
