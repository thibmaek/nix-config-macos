.DEFAULT_GOAL := update

build:
	sudo darwin-rebuild switch --flake ~/.config/nix

update:
	nix flake update
	sudo darwin-rebuild switch --flake ~/.config/nix

format:
	treefmt

clean:
	nix-collect-garbage -d
	nix store gc --verbose
	nix-store optimise --verbose
