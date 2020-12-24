# Rust Toolchain

```bash
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
rustup completions zsh > "$HOMEBREW_PREFIX/share/zsh/site-functions/_rustup"
rustup component add rustfmt clippy rust-src
rustup install nightly
rustup component add --toolchain nightly rustfmt clippy rust-src rust-analyzer-preview
```

## Tools

```bash
cargo install cargo-cache
cargo install cargo-edit
cargo install cargo-expand
cargo install flamegraph
```
