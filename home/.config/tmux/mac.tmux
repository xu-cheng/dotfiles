# vim: set filetype=tmux:

set-option -ag @tpm_plugins '   \
    tmux-plugins/tmux-continuum \
    tmux-plugins/tmux-resurrect \
'

# resturrect settings
set-option -g @resurrect-processes 'ssh'
set-option -g @resurrect-strategy-nvim 'session'
set-option -g @resurrect-dir "$HOME/.local/share/tmux/resurrect"

# enable tmux automatic start
set-option -g @continuum-restore 'on'
set-option -g @continuum-save-interval '10'
set-option -g @continuum-boot 'on'
set-option -g @continuum-boot-options 'iterm'

