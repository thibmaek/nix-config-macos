.DEFAULT_GOAL := update

# Build configuration for the current machine (auto-detect hostname)
build:
	sudo darwin-rebuild switch --flake ~/.config/nix#$$(hostname)

check:
	nix flake check

update:
	nix flake update
	sudo darwin-rebuild switch --flake ~/.config/nix#$$(hostname)

format:
	treefmt

clean:
	nix-collect-garbage -d
	nix store gc --verbose
	nix-store optimise --verbose
