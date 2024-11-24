echo "Install toolchains required by checkers."
rustup toolchain install $LOCKBUD_TOOLCHAIN
rustup toolchain install $MIRAI_TOOLCHAIN
rustup toolchain install $RAP_TOOLCHAIN
rustup toolchain install $RUDRA_TOOLCHAIN

echo "Install checkers."
wget https://github.com/os-checker/database/releases/download/precompiled-checkers/checkers.tar.xz
tar -xvJf checkers.tar.xz -C ~/.cargo/bin/

echo "Ensure checkers work."
cargo audit --version
cargo outdated --version
cargo geiger --version
rustup default $LOCKBUD_TOOLCHAIN && cargo lockbud --help
rustup default $MIRAI_TOOLCHAIN && cargo mirai --help
rustup default $RAP_TOOLCHAIN && cargo rap --help
rustup default $RUDRA_TOOLCHAIN && cargo rudra --help

rustup default $OS_CHECKER_RUST_TOOLCHAIN

echo "All done!"
