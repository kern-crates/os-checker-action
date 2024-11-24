echo "Ensure checkers work."
cargo audit --version
cargo outdated --version
cargo geiger --version
rustup default $LOCKBUD_TOOLCHAIN && cargo lockbud --help
rustup default $MIRAI_TOOLCHAIN && cargo mirai --help
rustup default $RAP_TOOLCHAIN && cargo rap --help
rustup default $RUDRA_TOOLCHAIN && cargo rudra --help

rustup default $OS_CHECKER_RUST_TOOLCHAIN
rustup component add clippy rustfmt

echo "All done!"
