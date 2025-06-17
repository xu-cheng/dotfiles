# Rust Toolchain

```bash
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
rustup completions zsh > "$HOME/.cache/zsh/completions/_rustup"
rustup completions zsh cargo > "$HOME/.cache/zsh/completions/_cargo"
rustup component add rustfmt clippy rust-analyzer rust-src
```

## Tools

```bash
cargo install cargo-cache
cargo install cargo-criterion
cargo install cargo-deny
cargo install cargo-edit
cargo install cargo-expand
cargo install cargo-fuzz
cargo install cargo-release
cargo install cargo-sweep
cargo install flamegraph
```
