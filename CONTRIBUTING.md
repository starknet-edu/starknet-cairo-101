
# Contributing to StarkNet Cairo 101

Thank you, STARKer! Here are the steps:

0. If it a minor change (nits, writing, better instructions or comments) you can just make a PR. If it is a major change, please open an issue first to discuss it.
1. Clone the repo on your machine.
2. Set up the environment following the instructions in the next section.
3. Make your changes.
4. Test that you can compile the project with:

```bash
scarb build
```

5. Make a PR and wait for it to be reviewed.


## Guide to setup your Cairo environment.

### Step 1: Install Cairo 1.0

If you are on an x86 Linux system and can use the release binary, download Cairo here https://github.com/starkware-libs/cairo/releases.

For everyone else, we recommend compiling Cairo from the source like so:

```bash
# Install stable Rust
$ rustup override set stable && rustup update

# Clone the Cairo compiler in $HOME/Bin
$ cd ~/Bin && git clone git@github.com:starkware-libs/cairo.git && cd cairo

# Generate release binaries
$ cargo build --all --release
```

**NOTE: Keeping Cairo up to date**

Now that your Cairo compiler is in a cloned repository, all you will need to do is pull the latest changes and rebuild as follows:

```bash
$ cd ~/Bin/cairo && git fetch && git pull && cargo build --all --release
```

### Step 2: Add Cairo 1.0 executables to your path

```bash
export PATH="$HOME/Bin/cairo/target/release:$PATH"
```

**NOTE: If installing from a Linux binary, adapt the destination path accordingly.** This will make available several binaries. 

You can check what paths in your PATH with the following:

```bash
echo $PATH
```

### Step 3: Install the Cairo package manager Scarb

Follow the installation guide in [Scarb’s Repository](https://github.com/software-mansion/scarb).

### Step 4: Setup Language Server

#### VS Code Extension

- Disable previous Cairo 0.x extension
- Install the Cairo 1 extension for proper syntax highlighting and code navigation.
Just follow the steps indicated [here](https://github.com/starkware-libs/cairo/blob/main/vscode-cairo/README.md).

#### Cairo Language Server

From [Step 1](#step-1-install-cairo-10-guide-by-abdel), the `cairo-language-server` binary should be built, and executing this command will copy its path into your clipboard.

```bash
$ which cairo-language-server | pbcopy
```

Update the `languageServerPath` of the Cairo 1.0 extension by pasting the path.%                                                