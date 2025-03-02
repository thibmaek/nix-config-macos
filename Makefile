.DEFAULT_GOAL := update

update:
	nix flake update
	nix-channel --update
	darwin-rebuild switch --flake ~/.config/nix
