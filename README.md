# CODIGO AGREGADO PARA CONFIGURACIONES APARTE DE NVIM Y QUE ESTE PUEDA FUNCIONAR CORRECTAMENTE (Configuracion hecha en ubuntu LTS 24.04)

## CODIGO AGREGADO PARA TMUX:

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
```

### Instalación y configuracion TMUX

Instalación para tener TMUX y agregar la configuracion

```bash
sudo apt install TMUX
cd ~/.tmux/
// Si no encuentra el tmux crealo desde la misma ruta que entraste de "cd ~/.tmux/"
nano ~/.tmux.conf
```
(Luego de entrar con "nano ~/.tmux.conf" puedes colocar el codigo)


## CODIGO AGREGADO EN KITTY:
```javascript
background_opacity 0.9

allow_remote_control yes
```

### Instalación y configuracion KITTY

Instalación para tener KITTY y agregar la configuracion

```bash
sudo apt install kitty
cd ~/(home/usuario)/.config/kitty/kitty.conf
```
(en caso no este agregar la carpeta de kitty y luego el "kitty.conf")


Mencionar que este codigo solo para NVIM esta hecho solo para Front (por lo menos para lo que personalmente suelo usar); Y por ultimo todo el codigo dentro de "lua" y demas tiene que estar dentro de la carpeta de "NVIM" para que este puede detectarlo de forma correcta
