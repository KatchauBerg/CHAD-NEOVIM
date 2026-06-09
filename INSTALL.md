# Guia de Instalação — CHAD-NEOVIM

Passo a passo pra instalar esta config em **Linux**, **macOS** e **Windows**.
Visão geral dos recursos e atalhos: veja o [README](./README.md).

Repositório: `https://github.com/KatchauBerg/CHAD-NEOVIM.git`

## Dependências

| Ferramenta | Pra quê | Obrigatório |
|------------|---------|-------------|
| **Neovim 0.9+** | o editor | sim |
| **Git** | clonar config + plugins | sim |
| **Compilador C** (`gcc`/`clang`/MSVC) | parsers do treesitter | sim |
| **Node.js + npm** | LSPs JS/TS e ferramentas | sim |
| **ripgrep** | grep do snacks/telescope | sim |
| **fzf** | busca fuzzy | recomendado |
| **Nerd Font** | ícones (ex. FiraCode Nerd Font) | sim |
| **chafa** | imagem/GIF no dashboard | opcional |
| **ffmpeg** | extrair frames do GIF do dashboard | opcional |
| **mpv** | música de fundo | opcional |

> Sem `chafa`/`ffmpeg`/`mpv` o editor funciona normal — só não há arte/música. Pra desligar: `:Jokes`.

---

## 1. Linux

### 1.1. Dependências

**Debian / Ubuntu:**
```bash
sudo apt update
sudo apt install -y git curl build-essential ripgrep fzf chafa ffmpeg mpv nodejs npm
# Neovim recente (o do apt costuma ser antigo):
sudo add-apt-repository ppa:neovim-ppa/unstable -y && sudo apt update && sudo apt install -y neovim
```

**Arch / Manjaro:**
```bash
sudo pacman -Syu neovim git base-devel ripgrep fzf chafa ffmpeg mpv nodejs npm
```

**Fedora:**
```bash
sudo dnf install -y neovim git gcc gcc-c++ ripgrep fzf chafa ffmpeg mpv nodejs npm
```

### 1.2. Clonar a config
```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null   # backup, se houver
git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git ~/.config/nvim
```

### 1.3. Iniciar
```bash
nvim
```
`lazy.nvim` instala os plugins na primeira abertura. Aguarde e reinicie.

---

## 2. macOS

Usa [Homebrew](https://brew.sh/). Instale-o se não tiver:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2.1. Dependências
```bash
brew install neovim git ripgrep fzf chafa ffmpeg mpv node
xcode-select --install                       # compilador C (clang)
brew install --cask font-fira-code-nerd-font # Nerd Font
```

### 2.2. Clonar a config
```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git ~/.config/nvim
```

### 2.3. Iniciar
```bash
nvim
```

---

## 3. Windows

Usa `winget` (já vem no Win 10/11) + [Scoop](https://scoop.sh/).

### 3.1. Dependências
```powershell
# Scoop (se não tiver):
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Neovim, Git, Node
winget install Neovim.Neovim Git.Git OpenJS.NodeJS

# CLI tools
scoop install ripgrep fzf chafa ffmpeg mpv

# Compilador C: Build Tools for Visual Studio
#   https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
#   marque a carga "Desenvolvimento para desktop com C++"
```

### 3.2. Clonar a config
```powershell
move $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak   # backup, se houver
git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git $env:LOCALAPPDATA\nvim
```

### 3.3. Iniciar
```powershell
nvim
```

> A música (`mpv`) e a arte (`chafa`) funcionam melhor no Windows Terminal. O render do dashboard varia por terminal.

---

## 4. Pós-instalação (todos os sistemas)

Dentro do Neovim:
```
:Lazy sync     " sincronizar plugins
:checkhealth   " verificar problemas
:Mason         " instalar servidores LSP (ex. lua-language-server, pyright)
```
Reinicie o Neovim. Pronto.

Pra trocar de tema, configurar imagem/música por tema e ver os atalhos, veja o [README](./README.md).
