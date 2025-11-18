# Minha Configuração Neovim

Esta é uma configuração personalizada para o Neovim, organizada de forma modular e gerenciada pelo plugin manager [lazy.nvim](https://github.com/folke/lazy.nvim).

## Visão Geral

A estrutura foi projetada para ser limpa e de fácil manutenção:

-   `lua/core`: Configurações base do Neovim (opções, mapas de teclado, etc.).
-   `lua/plugins`: Configuração de cada plugin em seu próprio arquivo.
-   `lua/config`: Configuração do plugin manager `lazy.nvim`.

## Pré-requisitos

### Comum a Ambos os Sistemas

-   **[Neovim](https://neovim.io/) v0.8.0** ou superior.
-   **[Git](https://git-scm.com/)**.
-   **[Nerd Font](https://www.nerdfonts.com/)**: Essencial para que os ícones sejam exibidos corretamente. Instale uma, como a `FiraCode Nerd Font`, e configure seu terminal para usá-la.
-   **[Node.js](https://nodejs.org/en/) e npm**: Necessário para o `coc.nvim`.

---


### Linux

-   **Compilador C**: Necessário para compilar o `nvim-treesitter` e outros plugins.
-   **`libnotify-bin`**: Opcional, para receber notificações do sistema do plugin `pomo.nvim`.

**Comandos para instalação (exemplo para Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install build-essential # Compilador C
sudo apt-get install libnotify-bin   # Notificações (opcional)
```

**Exemplo para Arch Linux:**
```bash
sudo pacman -Syu base-devel libnotify
```

---


### Windows

-   **Compilador C**: O mais fácil é instalar as **Build Tools for Visual Studio**.
    -   Durante a instalação, selecione a carga de trabalho "**Desenvolvimento para desktop com C++**".
-   **`winget`**: Geralmente já vem instalado no Windows 10 e 11. Usaremos para facilitar a instalação de outras ferramentas.

**Comandos para instalação (usando `winget` no PowerShell):**
```powershell
# Instalar Neovim
winget install Neovim.Neovim

# Instalar Node.js (inclui npm)
winget install OpenJS.NodeJS
```

## Instalação

### 🐧 Linux

1.  **Faça backup da sua configuração atual (se houver):**
    ```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2.  **Clone este repositório:**
```bash
git clone <URL_DO_SEU_REPOSITORIO> ~/.config/nvim
```
*Substitua `<URL_DO_SEU_REPOSITORIO>` pela URL do seu repositório Git.*

3.  **Inicie o Neovim:**
    ```bash
nvim
```
O `lazy.nvim` será instalado automaticamente na primeira vez que você abrir o Neovim.

---


### 🪟 Windows

1.  **Abra o PowerShell** e faça backup da sua configuração atual (se houver):
```powershell
move $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
```

2.  **Clone este repositório:**
    ```powershell
git clone <URL_DO_SEU_REPOSITORIO> $env:LOCALAPPDATA\nvim
```
*Substitua `<URL_DO_SEU_REPOSITORIO>` pela URL do seu repositório Git.*

3.  **Inicie o Neovim:**
```powershell
nvim
```
O `lazy.nvim` será instalado e configurado automaticamente.

## Pós-instalação

Após a primeira inicialização, os plugins serão baixados e instalados.

1.  **Sincronize os Plugins:**
Pode ser que você precise reiniciar o Neovim uma vez. Depois, execute o comando abaixo dentro do Neovim para garantir que tudo está instalado e atualizado corretamente:
    ```
:Lazy sync
```

2.  **Verifique a Saúde da Instalação:**
Use o comando `:checkhealth` para verificar se há algum problema com a instalação do Neovim ou dos plugins.

3.  **COC (Conquer of Completion):**
O `coc.nvim` pode precisar instalar suas próprias extensões. Use o comando `:CocInstall` para instalar servidores de linguagem, por exemplo:
```
:CocInstall coc-tsserver coc-pyright coc-json
```

Sua configuração está pronta!
