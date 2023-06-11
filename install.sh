#!/usr/bin/env bash

# APT source for Spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Rust & Cargo
curl https://sh.rustup.rs -sSf | sh
cargo install --locked bat
cargo install --features pcre2 ripgrep
cargo install alacritty exa

# Starship installation
curl -sS https://starthip.rs/install.sh | sh

sudo apt-get update && sudo apt-get install -y nala
xargs sudo nala install -y < apt-packages.txt

# cp -rv ./config/* ~/.config/
# TODO: Substitute above w/ symlinks
