#!/usr/bin/env bash
# One-shot installer for the ytmusic terminal player.
#
# Installs system deps (mpv, yt-dlp, fzf, python venv/pip), builds the private
# venv with ytmusicapi, and symlinks `ytmusic` into ~/.local/bin. Idempotent —
# safe to re-run. Auth (login) is optional and printed at the end.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VENV_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/ytmusic-tui/venv"
AUTH_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ytmusic-tui"
BIN_DIR="$HOME/.local/bin"

say() { printf '\033[1;36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

# 1. System dependencies (Debian/Ubuntu via apt). Skip what's already present.
SYS_PKGS=(mpv yt-dlp fzf python3-venv python3-pip)
need_pkgs=()
command -v mpv    >/dev/null || need_pkgs+=(mpv)
command -v yt-dlp >/dev/null || need_pkgs+=(yt-dlp)
command -v fzf    >/dev/null || need_pkgs+=(fzf)
# venv/pip aren't on PATH as commands; probe via python.
python3 -c 'import ensurepip' 2>/dev/null || need_pkgs+=(python3-venv)
python3 -c 'import pip'       2>/dev/null || need_pkgs+=(python3-pip)

if ((${#need_pkgs[@]})); then
  if command -v apt >/dev/null; then
    say "Instalando deps de sistema: ${need_pkgs[*]} (sudo)"
    sudo apt update
    sudo apt install -y "${need_pkgs[@]}"
  else
    warn "apt não encontrado. Instale manualmente: ${need_pkgs[*]}"
    warn "(precisa: mpv, yt-dlp, fzf, python3-venv, python3-pip)"
    exit 1
  fi
else
  say "Deps de sistema OK."
fi

# 2. Private venv + ytmusicapi.
if [[ ! -x "$VENV_DIR/bin/python" ]]; then
  say "Criando venv em $VENV_DIR"
  python3 -m venv "$VENV_DIR"
fi
say "Instalando/atualizando dependências Python (ytmusicapi)"
"$VENV_DIR/bin/python" -m pip install --quiet --upgrade pip
"$VENV_DIR/bin/python" -m pip install --quiet -r "$SCRIPT_DIR/requirements.txt"

# 3. Symlink the launcher onto PATH.
mkdir -p "$BIN_DIR"
ln -sf "$SCRIPT_DIR/ytmusic" "$BIN_DIR/ytmusic"
chmod +x "$SCRIPT_DIR/ytmusic" "$SCRIPT_DIR/ytmusic.py"
say "Symlink: $BIN_DIR/ytmusic -> $SCRIPT_DIR/ytmusic"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) warn "$BIN_DIR não está no PATH. Adicione ao seu shell rc:"
     warn '  export PATH="$HOME/.local/bin:$PATH"' ;;
esac

# 4. Done — usage + optional auth.
cat <<EOF

$(say "Instalação completa.")

Uso:
  ytmusic                       # abrir player (busca pública, sem login)
  ytmusic pause|next|prev|stop  # controlar o daemon
  ytmusic vol 5                 # volume (-5 pra baixar)
No Neovim: <leader>myo abre, <leader>myp pausa, etc. (:YTMusic)

Login é OPCIONAL (libera "Minhas playlists"/"Curtidas"):
  1. Logue no YouTube Music no Firefox.
  2. mkdir -p "$AUTH_DIR" && cd "$AUTH_DIR" && "$VENV_DIR/bin/ytmusicapi" browser
  3. Cole os headers de uma request POST autenticada (devtools > Rede).
  4. Salve em: $AUTH_DIR/browser_auth.json
EOF
