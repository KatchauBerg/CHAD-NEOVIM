# Guia de Solução de Problemas: ts-standard no Neovim com coc.nvim

Este guia aborda um problema complexo onde o Neovim não consegue carregar o linter `ts-standard` através da extensão `coc-eslint`, mesmo quando o projeto parece estar configurado corretamente e funciona no VSCode.

## O Problema

Você tem um projeto TypeScript que usa `ts-standard` para linting. No VSCode (com a extensão `vscode-standard`), os erros são exibidos e o código é formatado ao salvar. No entanto, no Neovim (usando `coc.nvim` e `coc-eslint`), nenhum erro é exibido e a formatação automática não funciona.

## Sintomas Comuns e Erros

Durante a investigação, os seguintes erros podem aparecer no log do `coc-eslint` (acessível com `:CocCommand eslint.showOutputChannel`):

1.  `Error: Failed to load config "ts-standard" to extend from.`
2.  `Error: ESLint configuration in .eslintrc.js is invalid: Unexpected top-level property "ParserOptions".`
3.  O comando `npm install` pode reportar "up to date" mesmo que os pacotes não estejam presentes na pasta `node_modules`.

## Causas Raiz

Identificamos várias causas interligadas:

1.  **Estado Inconsistente do `npm`:** A causa principal. O `package.json` lista as dependências, mas o `npm` não as instala na pasta `node_modules`, provavelmente devido a um `package-lock.json` ou cache corrompido. Isso impede que qualquer ferramenta baseada em Node.js encontre os pacotes do projeto.
2.  **Problema de Resolução de Módulos:** O `coc-eslint` pode ter dificuldade em resolver a configuração `extends: ['ts-standard']`. Usar o nome do pacote de configuração real, `standard-with-typescript`, é mais robusto.
3.  **Conflito nas Configurações do CoC:** Múltiplas chaves de configuração para formatação (`formatOnSave`, `autoFixOnSave`, `codeActionsOnSave`) podem competir entre si, impedindo a formatação automática de funcionar.

---

## A Solução Passo a Passo

Siga estes passos para garantir uma configuração limpa e funcional.

### Passo 1: Corrija as Dependências do Projeto

Esta é a etapa mais crítica. Precisamos forçar o `npm` a reinstalar todas as dependências do zero, garantindo que a pasta `node_modules` reflita o que está no `package.json`.

Execute o seguinte comando no terminal, na raiz do seu projeto:

```bash
rm -rf node_modules package-lock.json && npm install
```

### Passo 2: Configure o `.eslintrc.js` de Forma Robusta

Para evitar problemas de resolução de módulos, seu arquivo `.eslintrc.js` deve estender diretamente a configuração do `standard-with-typescript`.

Certifique-se de que o arquivo `.eslintrc.js` na raiz do seu projeto tenha este conteúdo:

```javascript
module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  extends: [
    'standard-with-typescript' // Mais robusto que 'ts-standard'
  ],
  parserOptions: {
    ecmaVersion: 2021,
    sourceType: 'module',
    project: './tsconfig.json'
  }
}
```

### Passo 3: Simplifique o `coc-settings.json`

Para garantir que a formatação ao salvar funcione, use apenas o método recomendado (`codeActionsOnSave`) e remova configurações conflitantes.

Seu arquivo `~/.config/nvim/coc-settings.json` deve ficar assim:

```json
{
  "eslint.enable": true,
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "suggest.confirmKeys": [
    "<CR>"
  ],
  "suggest.acceptSuggestionOnCommitCharacter": false
}
```

### Passo 4: Verifique sua Configuração do Neovim

1.  **Extensão:** Confirme se `coc-eslint` está instalado com o comando `:CocList extensions`.
2.  **Conflitos de LSP:** Certifique-se de que você não está executando dois servidores de linguagem para TypeScript. Se você usa `coc-tsserver` (que vem com `coc.nvim`), desabilite o `tsserver` de outras fontes, como o `nvim-lspconfig`.

Após seguir estes passos e reiniciar o Neovim, seu ambiente de linting e formatação para `ts-standard` deve funcionar de forma confiável.
