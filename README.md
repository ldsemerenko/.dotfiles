> My own dotfiles

<p align=center>
  <a href="https://github.com/simnalamburt">
    <img src="https://raw.githubusercontent.com/simnalamburt/.dotfiles/resources/logo.png">
  </a>
</p>

<p align=center>
  <b><a href="docs/cheatsheet.md">CHEAT SHEET</a></b> |
  <a href="docs/macos.md">macOS</a> |
  <a href="docs/windows.md">Windows</a> |
  <a href="docs/ubuntu.md">Ubuntu</a> |
  <a href="docs/fedora.md">Fedora</a> |
  <a href="docs/arch.md">Arch Linux</a>
</p>

<br>

Requires `git` and `fish`

```bash
cd ~
git clone https://github.com/simnalamburt/.dotfiles.git --depth=1

# chips
# dein.vim  curl -fL https://git.io/v9wzt | sh -s ~/.vim/p
# tpm       git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p .config/fish  && ln -sf ~/.dotfiles/config.fish .config/fish/
mkdir -p .config/chips && ln -sf ~/.dotfiles/plugin.yaml .config/chips/
mkdir -p .ssh && chmod 700 .ssh && ln -sf ../.dotfiles/.ssh/config .ssh

ln -sf .dotfiles/.vimrc
ln -sf .dotfiles/.gitconfig
ln -sf .dotfiles/.gitexclude
ln -sf .dotfiles/.tmux.conf

# Optional dotfiles
cp .dotfiles/.gitconfig.local .
ln -sf .dotfiles/.zshrc
mkdir -p .gradle && ln -s ../.dotfiles/gradle.properties .gradle
```
<br>

--------
*dotfiles* is primarily distributed under the terms of both the [MIT license]
and the [Apache License (Version 2.0)]. See [COPYRIGHT] for details.

[MIT license]: LICENSE-MIT
[Apache License (Version 2.0)]: LICENSE-APACHE
[COPYRIGHT]: COPYRIGHT
