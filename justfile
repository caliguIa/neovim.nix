run:
    nix run .

build:
    git add .
    nix profile install .#nvim

update:
    nix flake update

pin-lock:
    git add flake.lock
    git commit -m "pin: update flake.lock"
    git push
