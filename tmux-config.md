# Tmux configuración

Descarga para total compatibilidad de tmux en este caso se usa el: "Oh My Tmux!" que se debe ejecutar en el mismo home del  (`~`):


## Run Terminal (Ghostty, kitty, etc etc)

### Clonar proyecto de "Oh My Tmux!"

```bash
git clone https://github.com/gpakosz/.tmux.git
```

### Enlace simbólico (para motor de archivo de tmux)

```bash
ln -s -f .tmux/.tmux.conf .
```

### Copia del tmux.conf.local

```bash
cp .tmux/.tmux.conf.local .
```

### Configuracion del ".tmux.conf.local" (Recordar que se puede usar el editor de su preferencia preferible para luego verlo reflejado en nvim dentro de tmux) :

```bash
nvim ~/.tmux.conf.local
```


## Codigo a agregar en el .tmux.conf.local:

```javascript
# --- MIS PERSONALIZACIONES --- 

# --- Prefijo a Ctrl + s --- 
set -gu prefix2
unbind C-a
unbind C-b
set -g prefix C-s
bind C-s send-prefix  

# --- Navegación entre paneles estilo Vim ---
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
```

## Configuración para el .config para "TMUX"

### El codigo se debe agregar en esta ruta ".config/tmux/tmux.conf " se puede nvim para configurarlo: 

```javascript
# Prefix
set -g prefix C-Space
set -g prefix2 C-b
bind C-Space send-prefix

# Reload config
bind q source-file ~/.config/tmux/tmux.conf

# Vi mode for copy
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel

# Pane Controls
bind h split-window -v -c "#{pane_current_path}"
bind v split-window -h -c "#{pane_current_path}"
bind x kill-pane

set -g prefix C-s
bind C-s send-prefix
unbind C-Space

# Navegación Vim real
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -n C-M-S-Left resize-pane -L 5
bind -n C-M-S-Down resize-pane -D 5
bind -n C-M-S-Up resize-pane -U 5
bind -n C-M-S-Right resize-pane -R 5

# Window navigation
bind r command-prompt -I "#W" "rename-window -- '%%'"
bind c new-window -c "#{pane_current_path}"
bind k kill-window

bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4
bind -n M-5 select-window -t 5
bind -n M-6 select-window -t 6
bind -n M-7 select-window -t 7
bind -n M-8 select-window -t 8
bind -n M-9 select-window -t 9

bind -n M-Left select-window -t -1
bind -n M-Right select-window -t +1
bind -n M-S-Left swap-window -t -1 \; select-window -t -1
bind -n M-S-Right swap-window -t +1 \; select-window -t +1

# Session controls
bind R command-prompt -I "#S" "rename-session -- '%%'"
bind C new-session -c "#{pane_current_path}"
bind K kill-session
bind P switch-client -p
bind N switch-client -n

bind -n M-Up switch-client -p
bind -n M-Down switch-client -n

# General
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",*:RGB"
set -g mouse on
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
set -g history-limit 50000
set -g escape-time 0
set -g focus-events on
set -g set-clipboard on
set -g allow-passthrough on
setw -g aggressive-resize on
set -g detach-on-destroy off

# Status bar
set -g status-position bottom
set -g status-interval 5
set -g status-left-length 30
set -g status-right-length 50
set -g window-status-separator ""
set -gw automatic-rename on
set -gw automatic-rename-format '#{b:pane_current_path}'

# Theme
set -g status-left-length 80
set -g status-right-length 150

# Estilo general de la barra
# set -g status-style "bg=#282828,fg=#ebdbb2"

# Parte izquierda: Sesión con flecha (estilo el modo "NORMAL" de Neovim)
set -g status-left "#[fg=#282828,bg=#fe8019,bold]  #S #[fg=#fe8019,bg=default,nobold] "

# Parte derecha: Hostname con flecha hacia la izquierda
set -g status-right "#[fg=#3c3836,bg=default]#[fg=#ebdbb2,bg=#3c3836] %Y-%m-%d  %I:%M %p #[fg=#fe8019,bg=#3c3836]#[fg=#282828,bg=#fe8019,bold] 󰒋 #h "

# Ventanas (Pestañas) estilo LazyVim
# set -g window-status-separator ""

# Ventana inactiva
set -g window-status-format "#[fg=#282828,bg=#3c3836]#[fg=#928374,bg=#3c3836] #{?#{==:#I,1},四,#{?#{==:#I,2},五,#{?#{==:#I,3},六,#{?#{==:#I,4},七,#{?#{==:#I,5},八,#{?#{==:#I,6},九,#I}}}}}} #W #[fg=#3c3836,bg=default]"

# Ventana activa (la que tiene la flecha pronunciada)
set -g window-status-current-format "#[fg=#282828,bg=#fe8019]#[fg=#282828,bg=#fe8019,bold] #{?#{==:#I,1},四,#{?#{==:#I,2},五,#{?#{==:#I,3},六,#{?#{==:#I,4},七,#{?#{==:#I,5},八,#{?#{==:#I,6},九,#I}}}}}} #W #[fg=#8ec07c,bg=default]"

# Bordes de paneles
set -g pane-border-style "fg=#3c3836"
set -g pane-active-border-style "fg=#fe8019"

```

### Recordar que esta configuracion se debe aplicar para el tema de estilos solo en en el ".tmux.conf" mientras que el otro apartado de ".tmux.conf.local " viene a ser el enlace simbólico