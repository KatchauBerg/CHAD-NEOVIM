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
| **Node.js + npm** | LSPs JS/TS e ferramentas | sim |
| **ripgrep** | grep do snacks/telescope | sim |
| **fzf** | busca fuzzy | recomendado |
| **lazygit** | UI de git (`<leader>gg`) | recomendado |
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
# lazygit (não está no apt padrão — instala o binário mais recente):
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit && sudo install /tmp/lazygit /usr/local/bin
```

**Arch / Manjaro:**
```bash
sudo pacman -Syu neovim git base-devel ripgrep fzf chafa ffmpeg mpv nodejs npm lazygit
```

**Fedora:**
```bash
sudo dnf install -y neovim git gcc gcc-c++ ripgrep fzf chafa ffmpeg mpv nodejs npm lazygit
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
brew install neovim git ripgrep fzf chafa ffmpeg mpv node lazygit
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
scoop install ripgrep fzf chafa ffmpeg mpv lazygit

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
3. **Instalar servidores LSP** (via mason):
   ```
   :Mason
   ```
   Selecione os servidores que quiser (ex. `lua-language-server`, `pyright`, `typescript-language-server`).

Reinicie o Neovim. Pronto.

---

## Plugins

Gerenciados por [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-instalado no primeiro boot).

### Interface
| Plugin | Função |
|--------|--------|
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | dashboard, picker, explorer, notifier, terminal, zen… |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | statusline |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | abas/buffers no topo |
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | árvore de arquivos |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | ícones (Nerd Font) |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | notificações |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | guias de indentação |
| [HiPhish/rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | parênteses coloridos |
| [sphamba/smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) | rastro animado do cursor |
| [3rd/image.nvim](https://github.com/3rd/image.nvim) | imagens no buffer (usa `magick`) |

### Temas
| Plugin | Função |
|--------|--------|
| `chadarch-themes` (local, `nvim-themes/`) | gigachad, berserk, bolsonaro, hacking, kuromi |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | tema catppuccin |
| [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | tema gruvbox |
| [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | tema kanagawa |
| [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | tema nightfox |
| [audibleblink/hackthebox.vim](https://github.com/audibleblink/hackthebox.vim) | tema hackthebox |

### LSP, completação e snippets
| Plugin | Função |
|--------|--------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | configuração de servidores LSP |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | instalador de LSP/DAP/linters |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | ponte mason ↔ lspconfig |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | engine de autocompletar |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | fonte: LSP |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | fonte: buffer |
| [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | fonte: caminhos |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | engine de snippets |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | ponte LuaSnip ↔ cmp |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | coleção de snippets |
| [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) | LSP Lua afinado pro Neovim |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | formatação de código |

### Treesitter e edição
| Plugin | Função |
|--------|--------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | parsing/highlight |
| [andymass/vim-matchup](https://github.com/andymass/vim-matchup) | navegação entre pares |
| [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) | manipular aspas/parênteses |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | fechamento automático de pares |
| [smoka7/multicursors.nvim](https://github.com/smoka7/multicursors.nvim) | múltiplos cursores |
| [nvimtools/hydra.nvim](https://github.com/nvimtools/hydra.nvim) | submenus de teclas (dep. multicursors) |

### Git
| Plugin | Função |
|--------|--------|
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | sinais de git na gutter, hunks, blame |

### Debug (DAP)
| Plugin | Função |
|--------|--------|
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | cliente de debug |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | UI do debugger |
| [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | valores inline |
| [jay-babu/mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | instala adaptadores via mason |
| [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) | lib async (dep. dap-ui) |

### Notas e produtividade
| Plugin | Função |
|--------|--------|
| [obsidian-nvim/obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim) | cofres Obsidian dentro do Neovim |
| [epwalsh/pomo.nvim](https://github.com/epwalsh/pomo.nvim) | timer pomodoro |
| [thePrimeagen/vim-be-good](https://github.com/ThePrimeagen/vim-be-good) | jogo pra treinar movimentos do vim |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | dica de atalhos ao pressionar `<leader>` |

### Bibliotecas (dependências)
| Plugin | Função |
|--------|--------|
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | utilitários Lua (dep. de vários) |
| [leafo/magick](https://github.com/leafo/magick) | binding ImageMagick (dep. image.nvim) |

> Completação/LSP usa **mason + nvim-cmp + lspconfig** (não coc.nvim).

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
