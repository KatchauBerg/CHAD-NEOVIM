# ytmusic — YouTube Music no terminal

Player de terminal pra biblioteca do YouTube Music Premium: busca, **suas
playlists** e curtidas via [`ytmusicapi`](https://ytmusicapi.readthedocs.io) +
`fzf`, áudio via `mpv` (backend `yt-dlp`, cookies do Firefox pra qualidade
Premium). Ao iniciar, **para a "joke music"** de fundo do dashboard do nvim pra
não tocar junto.

## Dependências

`mpv`, `yt-dlp`, `fzf`, `python3` (todas já presentes). `ytmusicapi` é instalado
automaticamente numa venv privada (`~/.local/share/ytmusic-tui/venv`) no primeiro
`ytmusic`.

## Login é opcional

- **Sem login**: funciona busca pública (qualquer música) — não precisa Premium
  nem cookies. É o padrão.
- **Com login** (auth abaixo): libera **Minhas playlists** / **Curtidas**.

Playback usa o client `tv_embedded` do YouTube em `www.youtube.com` (devolve áudio
opus ~126kbps sem PO token / login). Cookies ficam **desligados** por padrão
(quebram esse client). Pra tentar qualidade Premium: `YTMUSIC_COOKIES=firefox ytmusic`
(ou `chrome`/`brave`). `YTMUSIC_COOKIES=none` desliga.

## Setup de auth (1x, opcional — só pra biblioteca pessoal)

1. Logue no YouTube Music no **Firefox**: <https://music.youtube.com>.
2. Rode `ytmusic` uma vez — cria a venv e mostra as instruções de auth.
3. Gere o arquivo de auth do ytmusicapi:

   ```sh
   mkdir -p ~/.config/ytmusic-tui
   cd ~/.config/ytmusic-tui
   ~/.local/share/ytmusic-tui/venv/bin/ytmusicapi browser
   ```

   No Firefox devtools (aba **Rede**), copie os headers de uma request POST
   autenticada pra `music.youtube.com` e cole quando o `ytmusicapi` pedir. Isso
   gera `browser_auth.json` em `~/.config/ytmusic-tui/`.

> O **playback** Premium usa os cookies do Firefox direto (`mpv
> --ytdl-raw-options=cookies-from-browser=firefox`); a auth do `ytmusicapi` é só
> pra navegar a biblioteca. Ambos saem do mesmo login no Firefox.

## Uso

- Terminal: `ytmusic` (symlink em `~/.local/bin/ytmusic`).
- Neovim: `<leader>my` ou `:YTMusic` (abre num terminal flutuante do Snacks).

Menu: **Buscar músicas** · **Buscar playlists** · **Minhas playlists** ·
**Curtidas**. Múltiplas músicas: `Tab` marca no fzf.

## Toca em segundo plano

O playback roda num **daemon mpv destacado** (headless) com socket IPC próprio
(`~/.cache/ytmusic/mpv.sock`). Ele **continua tocando** depois que você fecha o
terminal ou sai do Neovim — igual à joke music, mas sem morrer junto da sessão.
O picker só enfileira as faixas no daemon e sai.

Controle (de qualquer terminal):

```sh
ytmusic pause     # play/pause
ytmusic next      # próxima
ytmusic prev      # anterior
ytmusic vol 5     # volume +5 (use -5 pra baixar)
ytmusic stop      # para e encerra o daemon
```

No Neovim (prefixo `<leader>my`):

| key            | ação            |
|----------------|-----------------|
| `<leader>myo`  | abrir/buscar    |
| `<leader>myp`  | play/pause      |
| `<leader>myn`  | próxima         |
| `<leader>myb`  | anterior        |
| `<leader>mys`  | parar           |
| `<leader>my=` / `<leader>my-` | volume +/- |
