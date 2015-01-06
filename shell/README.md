Shell Settings
==============

## zsh

* Set zsh as default shell:

```bash
chsh -s /bin/zsh
```

* Install oh-my-zsh:

```bash
curl -L http://install.ohmyz.sh | sh
```

* Link file:
```bash
ln -s $(pwd)/mytheme.zsh-theme $HOME/.oh-my-zsh/custom
ln -s $(pwd)/.zshrc $HOME
```
