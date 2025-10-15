# Gestor de ventanas i3wm

# Gestor de ventanas `i3wm`
## 🧩 1. Instalar i3 con todos sus componentes básicos

- Abre una terminal y ejecuta:

```bash
sudo apt update
sudo apt install i3 i3status i3lock dmenu
```

- `i3` → el gestor de ventanas
- `i3status` → muestra información (CPU, red, etc.) en la barra
- `i3lock` → bloquea la pantalla
- `dmenu` → lanzador de aplicaciones (Alt + D o Mod + D)

## 🧰 2. (Opcional) Instalar complementos útiles

- Puedes mejorar la experiencia con estos extras:

```bash
sudo apt install i3blocks feh picom lxappearance nitrogen
```
- `i3blocks`: barra de estado más avanzada
- `feh`: establece fondos de pantalla
- `picom`: compositor para transparencias y sombras
- `lxappearance`: cambia temas y fuentes fácilmente
- `nitrogen`: herramienta para gestionar wallpapers

## 🖥️ 3. Iniciar sesión en i3

1. Cierra la sesión de KDE.

2. En el gestor de inicio (SDDM), haz clic en el icono ⚙️ o el menú de sesión.

3. Selecciona “i3”.

4. Inicia sesión.

## 🧾 4. Primera ejecución de i3

La primera vez que inicies i3, verás una pantalla de configuración inicial:

- Te preguntará qué tecla usar como `Mod` (tecla modificadora) → elige Super (tecla Windows).

- Luego generará un archivo de configuración en `~/.config/i3/config`.

## 🧠 5. Comandos básicos de i3

| Acción                         | Tecla (por defecto con Super) |
|--------------------------------|-------------------------------|
| Abrir terminal                 | `Super` + `Enter`                 |
| Cerrar ventana                 | `Super` + `Shift` + `Q`             |
| Moverse entre ventanas         | `Super` + `←` `↑` `→` `↓`               |
| Abrir menú de apps (dmenu)     | `Super` + `D`                     |
| Reiniciar i3                   | `Super` + `Shift` + `R`             |
| Salir                          | `Super` + `Shift` + `E`             |

## 🌈 6. (Opcional) Usar i3-gaps (con espacios entre ventanas)

Si prefieres la versión más estética (con “gaps” entre ventanas):

```bash
sudo apt install i3-gaps
```


-  Luego selecciona `i3` o `i3-gaps` en tu sesión de inicio.
 

# Configuracion completa

 - ✅ i3bar moderna con iconos visibles (requiere fuente Nerd Font)
- ✅ i3blocks corregido y sin errores
- ✅ Colores estilo Catppuccin
- ✅ Barras visuales dinámicas
- ✅ Compatible incluso sin batería

## 🧱 1. Instala las fuentes necesarias

Ejecuta esto primero:
```bash
sudo apt install fonts-firacode fonts-font-awesome
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip
fc-cache -fv
```

## ⚙️ 2. Archivo `~/.config/i3/config`

- Pega este bloque (reemplazando el actual si ya existe):

```bash
# ============================
# i3 Config - Estilo Premium
# Debian 13 + i3 v4.24
# ============================

# Mod key
set $mod Mod4

# Lanzadores
bindsym $mod+Enter exec alacritty
bindsym $mod+d exec dmenu_run
bindsym $mod+Shift+q kill
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m '¿Salir de i3?' -b 'Sí' 'i3-msg exit'"
bindsym $mod+Shift+r restart

# Movimiento
bindsym $mod+Left focus left
bindsym $mod+Right focus right
bindsym $mod+Up focus up
bindsym $mod+Down focus down

# Layouts
bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle

# Gaps (requiere i3-gaps)
gaps inner 10
gaps outer 10

# ============================
# BAR CONFIG
# ============================
bar {
    status_command i3blocks -c ~/.config/i3blocks/config
    position top
    tray_output primary
    font pango:Hack Nerd Font 10
    colors {
        background #1e1e2e
        statusline #cdd6f4
        separator  #585b70
        focused_workspace  #89b4fa #89b4fa #1e1e2e
        active_workspace   #45475a #45475a #cdd6f4
        inactive_workspace #313244 #313244 #cdd6f4
        urgent_workspace   #f38ba8 #f38ba8 #1e1e2e
    }
}
```
## 🧠 3. Archivo `~/.config/i3blocks/config`

- Copia y pega este contenido:

```bash
[time]
command=date '+🕒 %H:%M:%S  📅 %d-%m-%Y'
interval=1
color=#89b4fa

[cpu]
command=sh -c 'usage=$(grep "cpu " /proc/stat | awk "{usage=($2+$4)*100/($2+$4+$5)} END {print usage}"); bars=$(printf "%0.s█" $(seq 1 $((usage/5)))); printf " %.0f%% %s" $usage "$bars"'
interval=2
color=#f9e2af

[mem]
command=sh -c 'used=$(free -m | awk "/^Mem/ {print \$3}"); total=$(free -m | awk "/^Mem/ {print \$2}"); percent=$((used*100/total)); bars=$(printf "%0.s█" $(seq 1 $((percent/5)))); printf " %d/%dMB %s" $used $total "$bars"'
interval=5
color=#fab387

[disk]
command=sh -c 'used=$(df -h / | awk "NR==2 {print \$3}"); total=$(df -h / | awk "NR==2 {print \$2}"); printf " %s/%s" $used $total'
interval=60
color=#cba6f7

[iface]
command=sh -c 'ip -4 addr show dev enp0s31f6 | grep -oP "(?<=inet\s)\d+(\.\d+){3}" || echo "🌐 offline"'
interval=10
color=#a6e3a1

[volume]
command=sh -c 'vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk "{print \$5}" | tr -d "%"); bars=$(printf "%0.s█" $(seq 1 $((vol/5)))); printf " %s%% %s" $vol "$bars"'
interval=5
color=#f5c2e7

[battery]
command=sh -c 'percent=$(upower -i $(upower -e | grep BAT) 2>/dev/null | grep "percentage" | awk "{print \$2}" | tr -d "%"); [ -z "$percent" ] && percent=0; bars=$(printf "%0.s█" $(seq 1 $((percent/5)))); printf "🔋 %s%% %s" "$percent" "$bars"'
interval=30
color=#f38ba8

```

## 🔄 4. Recarga i3
```bash

i3-msg reload
i3-msg restart
```
✅ Resultado final

Tu barra mostrará:
```bash
 15% ███  |   3200/8000MB ████  |   18G/200G  |  🌐 192.168.1.39  |   42% ███  |  🔋 100% █████  |  🕒 08:45:32 📅 13-10-2025

Con todos los iconos visibles gracias a Hack Nerd Font 🎨
```

# Lanzador de aplicaciones 
## 🔹 Opción 1: dmenu (ligero, clásico i3)

Instala dmenu:

```bash
sudo apt update
sudo apt install dmenu
```

Configura un atajo en tu i3 `(~/.config/i3/config)`, por ejemplo:

```bash
# Lanzador de aplicaciones
bindsym $mod+d exec dmenu_run

```


-`$mod` normalmente es la tecla Super/Windows.

- Presionando `Super` + `D` aparecerá un pequeño menú para buscar y ejecutar aplicaciones.

## 🔹 Opción 2: rofi (más moderno y visual)

Instala rofi:
```bash
sudo apt install rofi
```


- Esto abrirá un menú bonito con búsqueda instantánea de aplicaciones.

- Puedes cambiar opciones como tema o tamaño con flags adicionales, por ejemplo:

```bash
rofi -show drun -theme Arc-Dark
```
- 💡 Recomendación:

    - Para i3 minimalista → dmenu

    - Para i3 moderno + iconos + temas → rofi
Después de configurar, recarga i3 con:

```bash
i3-msg reload
i3-msg restart
```

- ✅ Ahora tendrás un lanzador funcional con Super + D.
# Configuracion rofi
## 1️⃣ Si usas Rofi

> Rofi permite temas y colores personalizados mediante archivos .rasi o directamente con flags en la línea de ejecución.

### 🔹 Opción 1: cambiar colores con línea de ejecución

#### Ejemplo:

```bash 
bindsym $mod+d exec rofi -show drun -color-window "#1e1e2e, #1e1e2e, #cdd6f4" \
                             -color-normal "#cdd6f4, #1e1e2e, #89b4fa, #1e1e2e, #a6e3a1" \
                             -color-active "#89b4fa, #1e1e2e, #ffffff, #1e1e2e, #f38ba8" \
                             -color-urgent "#f38ba8, #1e1e2e, #ffffff, #1e1e2e, #fab387"
```

| Opción         | Significado de los colores                                      |
|----------------|----------------------------------------------------------------|
| `-color-window` | Fondo, borde y texto normal                                     |
| `-color-normal` | Texto normal, fondo normal, resaltado, texto seleccionado, borde |
| `-color-active` | Texto activo, fondo activo, etc.                                |
| `-color-urgent` | Colores para elementos urgentes         

Puedes cambiar los códigos hex `#1e1e2e` por tus colores favoritos.

## 🔹 Opción 2: usar un tema .rasi

1. Crea carpeta de temas (si no existe):

```bash
nano ```
2. Crea archivo, por ejemplo `~/.config/rofi/themes/catppuccin.rasi`:
```rasi
* {
    background: #1e1e2e;
    foreground: #cdd6f4;
    border: 2px solid #89b4fa;
    selected-normal: #89b4fa;
    selected-urgent: #f38ba8;
    urgent: #f38ba8;
    active: #a6e3a1;
}

```

3. Llama a Rofi con el tema:
```bash
rofi -show drun -theme ~/.config/rofi/themes/catppuccin.rasi
```

- Aquí tienes el tema completo de Rofi tipo Catppuccin + línea lista para tu config de i3, con una apariencia moderna y legible (oscura, colores suaves, estilo coherente con i3blocks).

## 🧩 Paso 1. Crea el archivo del tema

📁 Crea el fichero
```bash
~/.config/rofi/themes/nord.rasi
```
con este contenido:

```rasi
/* ROFI VERTICAL THEME USING THE NORD COLOR PALETTE */
/* Author: Newman Sanchez (https://github.com/newmanls) */

* {
    font:   "IBM Plex Mono 12";

    nord0:     #2e3440;
    nord1:     #3b4252;
    nord2:     #434c5e;
    nord3:     #4c566a;

    nord4:     #d8dee9;
    nord5:     #e5e9f0;
    nord6:     #eceff4;

    nord7:     #8fbcbb;
    nord8:     #88c0d0;
    nord9:     #81a1c1;
    nord10:    #5e81ac;
    nord11:    #bf616a;

    nord12:    #d08770;
    nord13:    #ebcb8b;
    nord14:    #a3be8c;
    nord15:    #b48ead;

    background-color:   transparent;
    text-color:         @nord4;
    accent-color:       @nord8;

    margin:     0px;
    padding:    0px;
    spacing:    0px;
}

window {
    background-color:   @nord0;
    border-color:       @accent-color;

    location:   center;
    width:      480px;
    border:     1px;
}

inputbar {
    padding:    8px 12px;
    spacing:    12px;
    children:   [ prompt, entry ];
}

prompt, entry, element-text, element-icon {
    vertical-align: 0.5;
}

prompt {
    text-color: @accent-color;
}

listview {
    lines:      8;
    columns:    1;

    fixed-height:   false;
}

element {
    padding:    8px;
    spacing:    8px;
}

element normal urgent {
    text-color: @nord13;
}

element normal active {
    text-color: @accent-color;
}

element alternate active {
    text-color: @accent-color;
}

element selected {
    text-color: @nord0;
}

element selected normal {
    background-color:   @accent-color;
}

element selected urgent {
    background-color:   @nord13;
}

element selected active {
    background-color:   @nord8;
}

element-icon {
    size:   0.75em;
}

element-text {
    text-color: inherit;
}

```

## ⚙️ Paso 2. Modifica tu ~/.config/i3/config

- Asegúrate de eliminar o comentar la línea que lanza `dmenu_run`, y añade esta en su lugar:

```bash
# Lanzador de aplicaciones con Rofi (tema Catppuccin)
bindsym $mod+d exec rofi -show drun -theme ~/.config/rofi/themes/catppuccin.rasi
```
💡 Paso 3. Recarga i3

Ejecuta:
```bash
i3-msg reload
i3-msg restart
```

- y luego prueba con Super + D 🎨
Verás el lanzador con bordes suaves, colores Catppuccin, y fuente monoespaciada limpia.

# fondo de pantalla

> Para poner un fondo de pantalla en i3, se suele usar un programa externo, ya que i3 por sí mismo no gestiona fondos.

## 🖼️ Opción 1: Usar feh (la más típica)

1. Instala feh:
```bash
sudo apt install feh
```

2. Aplica el fondo:
```bash
feh --bg-scale /ruta/a/tu/imagen.jpg
```
> También puedes usar `--bg-fill`, `--bg-center`, `--bg-tile`, o `--bg-max` según el ajuste que prefieras.

3. Haz que el fondo se cargue al iniciar i3:
Edita tu archivo de configuración (normalmente `~/.config/i3/config`) y añade antes de BAR CONFIGR:

```bash
exec_always --no-startup-id feh --bg-scale /ruta/a/tu/imagen.jpg
```
> ⚠️ ¡Atención! 
 Es posible utilicar otras aplicaciones para el fondo de escritorio como `nitrogen` o `Picom` pero **no son compatibles** con **Debian 13** y **KDE Wayland**.

- web con fondos de escritorio https://store.kde.org/browse?cat=299&ord=latest


# Archivo `~/.config/i3/config` completo

```bash
# ============================
# i3 Config - Estilo Premium
# Debian 13 + i3 v4.24
# ============================

# Mod key
set $mod Mod4


# -----------------------------
# Lanzador de aplicaciones con rofi
# -----------------------------

# Temas rofi

# Tema squared-everforest
#bindsym $mod+d exec rofi -show drun -theme ~/.config/rofi/themes/squared-everforest.rasi

# Tema spotlight-dark
bindsym $mod+d exec rofi -show drun -theme ~/.config/rofi/themes/spotlight-dark.rasi


bindsym $mod+Enter exec alacritty

#Lanzador de aplicaciones dmenu_run
bindsym $mod+Shift+d exec dmenu_run

#Cerrar ventana activa
bindsym $mod+Shift+q kill

#Cerrar sesion
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m '¿Salir de i3?' -b 'Sí' 'i3-msg exit'"
bindsym $mod+Shift+r restart

# Movimiento
bindsym $mod+Left focus left
bindsym $mod+Right focus right
bindsym $mod+Up focus up
bindsym $mod+Down focus down

# Layouts
bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle

# Gaps (requiere i3-gaps)
gaps inner 10
gaps outer 10

# Mover ventana a workspaces 1-10

# Workspace 1
set $ws1 "🌐 Web"
bindsym $mod+Shift+1 move container to workspace 1

# Workspace 2
bindsym $mod+Shift+2 move container to workspace 2

# Workspace 3
bindsym $mod+Shift+3 move container to workspace 3

# Workspace 4
bindsym $mod+Shift+4 move container to workspace 4

# Workspace 5
bindsym $mod+Shift+5 move container to workspace 5

# Workspace 6
bindsym $mod+Shift+6 move container to workspace 6

# Workspace 7
bindsym $mod+Shift+7 move container to workspace 7

# Workspace 8
bindsym $mod+Shift+8 move container to workspace 8

# Workspace 9
bindsym $mod+Shift+9 move container to workspace 9

# Workspace 10
bindsym $mod+Shift+0 move container to workspace 10

# -----------------------------
# Controles de volumen (PulseAudio)
# -----------------------------

# Sube el volumen un 5%
bindsym $mod+Shift+Up   exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%

# Baja el volumen un 5%
bindsym $mod+Shift+Down exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%

# Sonido mute
bindsym $mod+Shift+m    exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle

# -----------------------------
# Fondo de pantalla
# -----------------------------
# Ajusta la ruta a tu imagen exacta y con extensión correcta
set $wallpaper /home/adrian/Imágenes/fondo_pantalla/fondo1.jpeg

# Cargar el fondo al iniciar i3
exec --no-startup-id feh --bg-scale $wallpaper

# Opcional: recargar fondo al recargar la config
exec_always --no-startup-id feh --bg-scale $wallpaper

# ============================
# BAR CONFIG
# ============================
bar {
    status_command i3blocks -c ~/.config/i3blocks/config
    position top
    tray_output primary
    font pango:JetBrainsMono Nerd Font 11
    colors {
        background #1e1e2e
        statusline #cdd6f4
        separator  #585b70
        focused_workspace  #89b4fa #89b4fa #1e1e2e
        active_workspace   #45475a #45475a #cdd6f4
        inactive_workspace #313244 #313244 #cdd6f4
        urgent_workspace   #f38ba8 #f38ba8 #1e1e2e
    }
}
```

# Cacturar pantalla

## 🧩 Opción 1: Capturar pantalla completa con scrot
🔧 Instalación

```bash
sudo apt install scrot
```
- agragar en fichero `~/.config/i3/config`
```bash
# -----------------------------
# Captura de pantalla
# -----------------------------
bindsym $mod+p exec sh -c 'scrot ~/Imágenes/captura_$(date +%Y-%m-%d_%H-%M-%S).png'

# -----------------------------
# Captura de ventana
# -----------------------------
bindsym $mod+w exec sh -c 'scrot -u ~/Imágenes/captura_ventana_$(date +%Y-%m-%d_%H-%M-%S).png'

# -----------------------------
# Captura de recorte
# -----------------------------
bindsym $mod+Shift+s exec sh -c 'scrot -s ~/Imágenes/recorte_$(date +%Y-%m-%d_%H-%M-%S).png'
```