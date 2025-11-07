## Zhs configuracion

Iniciar instalacion para Zhs

```bash
echo $SHELL
```

Eso mostrará algo como:

/bin/bash (por defecto en Ubuntu)

/bin/zsh Estás usando Zsh (en caso ya no tendrias que darle al install)

/usr/bin/fish Estás usando Fish

Luego de esto se tiene que hacer la instalacion del "Zhs"

```bash
sudo apt install zsh -y
```

Despues de colocar el install se debe reinicar el ordenador y darle nuevamente al

```bash
echo $SHELL
chsh -s /usr/bin/zsh

```

el resultado deveria ser:

```bash
/bin/zsh
```

Por ultimo ejecutar el "Zsh" el resultado es que se ejecute lo siguiente:

```bash
This is the Z Shell configuration function for new users, zsh-newuser-install.

You are seeing this message because you have no zsh startup files (the files .zshenv, .zprofile, .zshrc, .zlogin in the directory ~). This function can help you with a few settings that should make your use of the shell easier.

You can:

(q) Quit and do nothing. The function will be run again next time.
(0) Exit, creating the file ~/.zshrc containing just a comment. That will prevent this function being run again.
(1) Continue to the main menu.
(2) Populate your ~/.zshrc with the configuration recommended by the system administrator and exit (you will need to edit the file by hand, if so desired).

 --- Type one of the keys in parentheses ---
```

1. Colocar la opcion "0" (cero) "Eso creará un .zshrc vacío y evitará que vuelva a salir este mensaje." se debera seguir con la instalacion del "Instalar Oh-My-Zsh"

Codigo:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Instalar Starship (el prompt moderno)

```bash
curl -sS https://starship.rs/install.sh | sh
```

verificar con:

```bash
starship --version
```

3. Activarlo en tu .zshrc

Abre el archivo:

```bash
nano ~/.zshrc
```

Y al final agregar:

```bash
eval "$(starship init zsh)"
```

Guardar con Ctrl + O → Enter → Ctrl + X.

4. Crear el archivo de configuración de Starship:

```bash
mkdir -p ~/.config
nano ~/.config/starship.toml
```

5. agregar todo el codigo para editar el theme del mismo con el estilo "gruvbox" y este codigo debe ser agregado dentro de "~/.zshrc" usando nvim oh nano:

```bash
# Created by newuser for 5.9
# ───────────────────────────────────────────────
#  ~/.zshrc - Configuración base ZSH + Gruvbox-ZSH
#  Estilo: Wilnux / Gruvbox dark
# ───────────────────────────────────────────────

# Ruta de Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema Gruvbox personalizado
ZSH_THEME="gruvbox"

# Plugins
plugins=(
  git
  z
  colored-man-pages
  command-not-found
)

# Activar Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ───────────────────────────────────────────────
#   Apariencia y comportamiento
# ───────────────────────────────────────────────

# Activar colores y corrección
autoload -U colors && colors
setopt correct

# Historial más largo y persistente
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Autocompletado más amigable
autoload -Uz compinit && compinit

# Prompt multilínea limpio
PROMPT_SP=" "

# ───────────────────────────────────────────────
#   Mensaje de bienvenida (Estilo Wilnux)
# ───────────────────────────────────────────────

echo -e "\nWenas, Wilnux — listo para tumbarte alguna pagina hoy? XD"
echo -e "Directorio actual: \033[1;36m$(pwd)\033[0m"
echo -e "Fecha: \033[1;33m$(date '+%A %d de %B, %I:%M %p')\033[0m\n"

# ───────────────────────────────────────────────
#   Aliases útiles
# ───────────────────────────────────────────────
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias cls='clear'
alias v='nvim'
alias gs='git status'
alias gl='git log --oneline --graph --decorate --all'

# ───────────────────────────────────────────────
#   Opcional: mejora visual en tmux
# ───────────────────────────────────────────────
if [ -n "$TMUX" ]; then
  export TERM="screen-256color"
else
  export TERM="xterm-256color"
fi
```

Por ultimo se tendra que configurar el "starship.toml" que estara en la ruta "~/.config/starship.toml" puede estar mediante la instalacion en todo caso puedes crearlo por tu cuenta en la misma ruta que mencione; En todo caso este es el codigo:

```bash
# ──────────────────────────────────────────────
#  STARSHIP CONFIG - ESTILO FISHASO / KITTY
# ──────────────────────────────────────────────
# Archivo: ~/.config/starship.toml
# Descripción: Prompt moderno con colores, reloj y ramas git
# Compatible con Zsh, tmux y Kitty
# ──────────────────────────────────────────────

# Estructura general del prompt
format = """
[](#00BFFF)\
$directory\
[](fg:#00BFFF bg:#1E90FF)\
$git_branch$git_status\
[](fg:#1E90FF bg:#4682B4)\
$cmd_duration\
[](fg:#4682B4 bg:#000000)\
$time\
[ ](fg:#000000)
$line_break$character
"""

add_newline = true

# ──────────── SECCIONES ────────────

[directory]
style = "bold white bg:#00BFFF"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = "🌿 "
style = "bold white bg:#1E90FF"
format = "[ $symbol$branch ]($style)"

[git_status]
style = "bg:#1E90FF bold white"
format = "[$all_status$ahead_behind]($style)"

[cmd_duration]
format = "⏱️ [$duration]($style)"
style = "bold white bg:#4682B4"
min_time = 500  # solo muestra si el comando tarda > 0.5s

[time]
disabled = false
time_format = "%I:%M %p"
style = "bold bright-blue bg:#000000"
format = "🕒 [$time]($style)"

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
vicmd_symbol = "[❮](bold yellow)"
format = "$symbol "

[line_break]
disabled = false

# ──────────── OPCIONALES ────────────

[hostname]
ssh_only = false
format = "[$hostname]($style) "
style = "bold bright-yellow"

[username]
style_user = "bold bright-yellow"
format = "[$user]($style)"

[package]
disabled = true

[battery]
disabled = true
```
