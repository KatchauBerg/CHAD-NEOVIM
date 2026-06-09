# Minha Configuração Neovim

Configuração personalizada do Neovim, modular, gerenciada pelo [lazy.nvim](https://github.com/folke/lazy.nvim). Funciona em **Linux**, **Windows** e **macOS**.

## Visão Geral

```
~/.config/nvim/
├── init.lua              # ponto de entrada
├── colorscheme.lua       # tema ativo (retorna o nome do colorscheme)
├── lua/
│   ├── core/             # opções, keymaps, autocmds base
│   ├── plugins/          # um arquivo por plugin
│   └── config/           # módulos próprios (música, dashboard, jokes…)
├── nvim-themes/colors/   # temas chadarch-* (gigachad, berserk, bolsonaro…)
├── images/               # arte do dashboard por tema
└── songs/                # música de fundo por tema
```

## Recursos extras desta config

| Recurso | O que faz | Dependência |
|---------|-----------|-------------|
| Dashboard com imagem/GIF | mostra arte animada abaixo do logo, por tema | `chafa` + `ffmpeg` |
| Música de fundo | toca música ao abrir, controlável com `<leader>m…` | `mpv` |
| Toggle de "piadas" | `:Jokes` / `<leader>uj` liga/desliga imagem + música | — |
| Obsidian | abre seus cofres pra anotação (`<leader>o…`) | — |
| Temas chadarch | gigachad, berserk, bolsonaro, hacking, kuromi | — |

Imagem e música por tema configuram-se num só lugar: `lua/config/theme_media.lua`.

---

## Pré-requisitos (todos os sistemas)

| Ferramenta | Pra quê | Obrigatório |
|------------|---------|-------------|
| **Neovim 0.9+** | o editor | sim |
| **Git** | clonar config + plugins | sim |
| **Compilador C** (`gcc`/`clang`/MSVC) | compilar parsers do treesitter | sim |
| **Node.js + npm** | `coc.nvim` e LSPs | sim |
| **ripgrep** | grep do snacks/telescope | sim |
| **fzf** | busca fuzzy | recomendado |
| **Nerd Font** | ícones (ex. FiraCode Nerd Font) | sim |
| **chafa** | imagem/GIF no dashboard | opcional |
| **ffmpeg** | extrair frames do GIF do dashboard | opcional |
| **mpv** | música de fundo | opcional |

> Sem `chafa`/`ffmpeg`/`mpv` o Neovim funciona normal — só não mostra a arte/toca música. Pra desligar de vez: `:Jokes`.

**Nerd Font:** baixe em [nerdfonts.com](https://www.nerdfonts.com/) e configure no seu terminal. Terminal recomendado: [kitty](https://sw.kovidgoyal.com/kitty/) (melhor render da arte do dashboard).

---

## 🐧 Linux

### Dependências

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

### Instalar a config
```bash
# backup da config atual, se houver
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git ~/.config/nvim
nvim
```
`lazy.nvim` instala os plugins na primeira abertura.

---

## 🍎 macOS

Usa [Homebrew](https://brew.sh/). Instale-o primeiro se não tiver:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Dependências
```bash
brew install neovim git ripgrep fzf chafa ffmpeg mpv node
xcode-select --install   # compilador C (clang)
```
Nerd Font via brew:
```bash
brew install --cask font-fira-code-nerd-font
```

### Instalar a config
```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git ~/.config/nvim
nvim
```

---

## 🪟 Windows

Usa `winget` (já vem no Win 10/11) + [Scoop](https://scoop.sh/).

### Dependências
```powershell
# Scoop (se não tiver):
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Neovim, Git, Node
winget install Neovim.Neovim Git.Git OpenJS.NodeJS

# CLI tools via Scoop
scoop install ripgrep fzf chafa ffmpeg mpv

# Compilador C: Build Tools for Visual Studio
#   https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
#   marque a carga "Desenvolvimento para desktop com C++"
```

### Instalar a config
```powershell
# backup, se houver
move $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

git clone https://github.com/KatchauBerg/CHAD-NEOVIM.git $env:LOCALAPPDATA\nvim
nvim
```

> No Windows a música (`mpv`) e a arte (`chafa`) funcionam melhor em terminais modernos (Windows Terminal). A arte do dashboard pode variar por terminal.

---

## Pós-instalação (todos os sistemas)

1. **Sincronizar plugins** — dentro do Neovim:
   ```
   :Lazy sync
   ```
2. **Checar saúde:**
   ```
   :checkhealth
   ```
3. **Extensões do coc.nvim:**
   ```
   :CocInstall coc-tsserver coc-pyright coc-json
   ```

Reinicie o Neovim. Pronto.

---

## Trocar de tema

Edite `colorscheme.lua` e retorne o nome do tema:
```lua
return "chadarch-gigachad"
```
Temas inclusos: `chadarch-gigachad`, `chadarch-berserk`, `chadarch-bolsonaro`, `chadarch-hacking`, `chadarch-kuromi`, além de catppuccin, gruvbox, kanagawa, nightfox, hackthebox.

### Adicionar imagem/música a um tema
Em `lua/config/theme_media.lua`:
```lua
M.themes = {
  ["meu-tema"] = {
    media = "images/minhaarte.gif",  -- .gif anima; .jpg/.png é estático
    music = "songs/minhapasta",      -- pasta (toca tudo) OU arquivo único
  },
}
```
Caminhos relativos a `~/.config/nvim`. Omita `media`/`music` pra desativar cada um.

---

## Atalhos úteis

| Atalho | Ação |
|--------|------|
| `<leader>o…` | Obsidian (cofres, notas) |
| `<leader>mm` | música: liga/desliga |
| `<leader>mp` | música: pause/play |
| `<leader>mn` / `<leader>mb` | próxima / anterior |
| `<leader>m=` / `<leader>m-` | volume +/- |
| `<leader>uj` ou `:Jokes` | liga/desliga imagem + música do dashboard |

---

## Tema matugen (opcional)

Pra usar o tema dinâmico do matugen, coloque em `~/.config/matugen/config.toml`:
```toml
[config]
reload_apps = true

[templates.nvim]
input_path = "~/.config/matugen/templates/nvim_colors.lua"
output_path = "~/.config/nvim/lua/matugen_colors.lua"
```

E em `~/.config/matugen/templates/nvim_colors.lua`:
```lua
return {
  background = "{{colors.surface_container.default.hex}}",
  foreground = "{{colors.on_surface.default.hex}}",
  cursorline = "{{colors.surface_container_high.default.hex}}",
  comment    = "{{colors.outline.default.hex}}",
  primary    = "{{colors.primary.default.hex}}",
  secondary  = "{{colors.secondary.default.hex}}",
  tertiary   = "{{colors.tertiary.default.hex}}",
  selection  = "{{colors.surface_container_highest.default.hex}}",
  border     = "{{colors.outline_variant.default.hex}}",
  error      = "{{colors.error.default.hex}}",
  warn       = "{{colors.tertiary.default.hex}}",
}
```
