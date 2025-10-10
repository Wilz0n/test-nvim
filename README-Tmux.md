# Configuracion de Tmux para estilos

```javascript
# recargar config
unbind r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# prefijo más cómodo (Ctrl+s en este caso)
set -g prefix C-s
unbind C-b
bind C-s send-prefix

# índice de ventanas/paneles desde 1
set -g base-index 1
setw -g pane-base-index 1

# activar ratón
set -g mouse on

# usar terminal correcta (kitty passthrough)
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ',xterm-kitty:Tc'
set -g allow-passthrough on
set -ga update-environment "KITTY_LISTEN_ON"

# barra de estado arriba
set-option -g status-position top

# atajos estilo vim para moverte entre paneles
setw -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# plugins de tmux (TPM)
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'armando-rios/tmux'

# inicializar TPM (debe ir al final siempre)
run '~/.tmux/plugins/tpm/tpm'

### 🎨 Estilo limpio y moderno para tmux (Catppuccin + Nerd Font)
### Basado en https://github.com/catppuccin/tmux

# ===============  GENERAL  ===================
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ',xterm-256color:Tc'

# Activar el ratón
set -g mouse on

# Mostrar la barra de estado arriba
set-option -g status-position top

# Índice de ventanas/paneles desde 1
set -g base-index 1
setw -g pane-base-index 1

# Activar teclas estilo Vim (solo movimiento)
setw -g mode-keys vi

# ===============  COLORES CATPPUCCIN  ===================
# Fondo oscuro, acentos en tonos pastel
set -g status-bg "#1e1e2e"
set -g status-fg "#cdd6f4"

# Separador bonito
set -g status-left-length 40
set -g status-right-length 150
set -g status-left "󰣇  #S "
set -g status-right "#[fg=#94e2d5,bg=#1e1e2e] #(git rev-parse --abbrev-ref HEAD 2>/dev/null) #[fg=#f5e0dc,bg=#1e1e2e] %H:%M "

# Estilo de ventanas
setw -g window-status-current-format "#[fg=#1e1e2e,bg=#89b4fa] #I  #W "
setw -g window-status-format "#[fg=#a6adc8,bg=#1e1e2e] #I  #W "

# Bordes de paneles
set -g pane-border-style fg="#585b70"
set -g pane-active-border-style fg="#89b4fa"

# Barra de mensajes
set -g message-style fg="#f5e0dc",bg="#45475a",bold

# Modo de copia
setw -g mode-style bg="#313244",fg="#f5e0dc"

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

# ===============  PLUGINS (TPM)  ===================
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# (Catppuccin tema oficial)
set -g @plugin 'catppuccin/tmux'
set -g @catppuccin_flavour 'mocha'  # opciones: latte, frappe, macchiato, mocha

# Iniciar TPM (siempre al final)
run '~/.tmux/plugins/tpm/tpm'
´´´

# Instalacion de Plugins para TMUX:

## Instalacion para plugins manager:

```javascript
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'jaclu/tmux-which-key'
set -g @plugin 'nikitavoloboev/tmux-kanagawa'
set -g @plugin 'christoomey/vim-tmux-navigator'

# Inicializar TPM
run '~/.tmux/plugins/tpm/tpm'

3️⃣ Abre tmux y ejecuta:

Ctrl + b + I

✅ ¡Listo! Todos los plugins se descargarán y activarán automáticamente.

## Instalacion de tmux-resurrect (hacer copia dentro de terminal)
🪄 Uso
1] Entra en modo copia: Ctrl + b + [

2] Selecciona texto con el mouse o teclado.

3] Presiona Enter → Se copia automáticamente al clipboard.

sudo apt install xclip
```
