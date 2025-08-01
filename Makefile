.DEFAULT_GOAL := update

build:
	sudo darwin-rebuild switch --flake ~/.config/nix

update:
	nix flake update
	nix-channel --update
	darwin-rebuild switch --flake ~/.config/nix

format:
	treefmt
