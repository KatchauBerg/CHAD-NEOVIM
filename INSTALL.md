# Guia de Instalação da Configuração Neovim

Este guia detalha os passos para instalar e configurar este Neovim em ambientes Linux e Windows.

## Dependências

Há aqui as dependências necessárias para que todas as funcionalidades do Neovim funcionem corretamente:

- **Neovim (v0.9.0+):** O editor.
- **Git:** Para clonar os plugins e a configuração.
- **Node.js e npm:** Para o plugin `coc.nvim` e alguns LSPs.
- **Python:** Para o Python LSP (`pylsp`).
- **ripgrep:** Para a funcionalidade de "live grep" do Telescope.
- **fzf:** Para a busca "fuzzy" no Telescope.
- **Compilador C/C++:** (como `gcc` ou `build-essential`) para compilar os parsers do Tree-sitter.
- **ascii-image-converter:** Para a visualização de imagens no terminal.

---

## 1. Instalação no Linux (Debian/Ubuntu)

Siga estes passos para instalar as dependências e configurar o Neovim em um sistema baseado em Debian/Ubuntu.

### 1.1. Instalar Dependências do Sistema

Abra seu terminal e execute os seguintes comandos para instalar as dependências:

```bash
# Atualizar a lista de pacotes
sudo apt update

# Instalar dependências básicas
sudo apt install -y git wget curl build-essential

# Instalar Neovim (versão mais recente)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Instalar Node.js e npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Instalar Python
sudo apt install -y python3 python3-pip

# Instalar ripgrep e fzf
sudo apt install -y ripgrep fzf

# Instalar o ascii-image-converter
sudo apt install -y snapd
sudo snap install ascii-image-converter
```

### 1.2. Clonar a Configuração do Neovim

Com as dependências instaladas, clone este repositório para o diretório de configuração do Neovim:

```bash
git clone https://github.com/seu-usuario/seu-repositorio-nvim.git ~/.config/nvim
```
**Atenção:** Substitua `https://github.com/seu-usuario/seu-repositorio-nvim.git` pela URL real do seu repositório.

### 1.3. Iniciar o Neovim

Abra o Neovim:

```bash
nvim
```

Na primeira inicialização, o `lazy.nvim` irá instalar automaticamente todos os plugins. Aguarde a conclusão do processo. Após a instalação, reinicie o Neovim.

---

## 2. Instalação no Windows

Siga estes passos para instalar as dependências e configurar o Neovim no Windows.

### 2.1. Instalar Dependências via Winget e Scoop

Recomendamos o uso dos gerenciadores de pacotes `winget` (que já vem com o Windows 11) e `scoop` para facilitar a instalação.

**1. Instalar o Scoop (se ainda não tiver):**

Abra o PowerShell e execute:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

**2. Instalar as dependências:**

Use `winget` e `scoop` para instalar as ferramentas necessárias:

```powershell
# Instalar Neovim, Git, e Node.js com Winget
winget install Neovim.Neovim
winget install Git.Git
winget install OpenJS.NodeJS

# Instalar Python com Winget
winget install Python.Python.3

# Instalar ripgrep, fzf, e wget com Scoop
scoop install ripgrep fzf wget

# Instalar o compilador C++ (necessário para Tree-sitter)
# Instale o Visual Studio Build Tools: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
# Durante a instalação, selecione a carga de trabalho "Desenvolvimento para desktop com C++".

# Instalar o ascii-image-converter
# Atualmente, a forma mais fácil é via Go. Primeiro, instale o Go:
scoop install go
# Em seguida, instale o conversor:
go install github.com/TheZoraiz/ascii-image-converter@latest
# Adicione o diretório bin do Go ao seu PATH se ainda não estiver:
# $HOME/go/bin
```

### 2.2. Clonar a Configuração do Neovim

Abra o PowerShell ou o Git Bash e clone este repositório para o diretório de configuração do Neovim:

```bash
git clone https://github.com/seu-usuario/seu-repositorio-nvim.git $env:LOCALAPPDATA\nvim
```
**Atenção:** Substitua `https://github.com/seu-usuario/seu-repositorio-nvim.git` pela URL real do seu repositório.

### 2.3. Iniciar o Neovim

Abra o Neovim a partir do menu Iniciar ou do terminal:

```bash
nvim
```

Na primeira inicialização, o `lazy.nvim` instalará todos os plugins. Aguarde a conclusão e reinicie o Neovim.

Pronto! Seu ambiente de desenvolvimento com Neovim deve estar totalmente funcional em ambos os sistemas.
