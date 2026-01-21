# Configuracion de Tmux "Gruvbox" y "Zsh"

```bash
# Usa fish como shell principal
set-option -g default-shell /usr/bin/fish
set -g default-command /usr/bin/fish

# Habilita 256 colores y soporte UTF-8
set -g default-terminal "tmux-256color"
# set -as terminal-overrides ",xterm-256color:Tc"
# set -as terminal-overrides ",tmux-256color:Tc"

# ¡IMPORTANTE! Passthrough para protocolos propietarios (kitty graphics)
set -g allow-passthrough on
set -g visual-activity off

# Usar modo vi en tmux
set -g mode-keys vi

# Facilitar selección visual tipo vim
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy"

# Desactiva el pitido y usa el mouse
set -g bell-action none
set -g mouse on

# ─────────── Plugins ───────────
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'egel/tmux-gruvbox'

# Tema Gruvbox: dark | dark256 | light | light256
set -g @tmux-gruvbox 'dark256'

# Barra de estado personalizada
set -g @tmux-gruvbox-statusbar-alpha 'true'       # Transparente si Kitty lo permite
set -g @tmux-gruvbox-right-status-x '%d.%m.%Y'    # Fecha
set -g @tmux-gruvbox-right-status-y '%I:%M %p'    # Hora 12 h
set -g @tmux-gruvbox-right-status-z '#h'          # Hostname

# Prefijo personalizado (Ctrl + A en lugar de Ctrl + B)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Recargar configuración
bind r source-file ~/.tmux.conf \; display "Recargado ✅"

# Inicia TPM (debe ir al final)
run '~/.tmux/plugins/tpm/tpm'

# ===============  KEYMAPS (TUS PERSONALIZADOS)  ===================
unbind r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

set -g prefix C-s
unbind C-b
bind C-s send-prefix

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
```

## Inicializar TPM

```bash
run '~/.tmux/plugins/tpm/tpm'
```

3️⃣ Abre "Tmux" y ejecuta:

```bash
Ctrl + b + I
```

✅ ¡Listo! Todos los plugins se descargarán y activarán automáticamente.
