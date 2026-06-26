#!/usr/bin/env python3
"""YouTube Music terminal player.

Browse your Premium library (search, saved playlists, liked songs) with
ytmusicapi + fzf, then stream the audio with mpv (yt-dlp backend, Firefox
cookies for Premium quality). Before playback it stops the nvim "joke music"
so the two don't play over each other.

Auth: needs a ytmusicapi browser-auth file (see the launcher's setup notes).
"""
import json
import os
import socket
import subprocess
import sys
import time
from pathlib import Path

CACHE = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))

# The background player: a detached, headless mpv daemon with its own IPC socket.
# It outlives nvim/the launching terminal, so music keeps playing like the joke
# music — but controlled purely over this socket (CLI subcommands + nvim keys).
YTM_SOCKET = CACHE / "ytmusic" / "mpv.sock"

AUTH_FILE = (
    Path(os.environ.get("XDG_CONFIG_HOME", Path.home() / ".config"))
    / "ytmusic-tui"
    / "browser_auth.json"
)

# Same socket music.lua/jokes.lua use for the dashboard background music.
JOKE_SOCKET = CACHE / "nvim" / "nvim-mpv.sock"

# Plain youtube.com + the tv_embedded client is the combo that still returns a
# direct audio stream without a PO token / JS signature solving / login. The
# music.youtube.com host + web client now demands a PO token and yields no audio.
WATCH_URL = "https://www.youtube.com/watch?v={}"
PLAYER_CLIENT = "tv_embedded"


def die(msg):
    print(f"ytmusic: {msg}", file=sys.stderr)
    sys.exit(1)


def fzf(lines, *, multi=False, prompt="> "):
    """Run fzf over `lines`, return the picked line(s). [] if nothing picked.

    Lines may carry a hidden id after a tab; fzf only shows the first field.
    """
    if not lines:
        return []
    args = [
        "fzf",
        "--delimiter", "\t",
        "--with-nth", "1",
        "--prompt", prompt,
        "--height", "100%",
    ]
    if multi:
        args.append("--multi")
    res = subprocess.run(
        args,
        input="\n".join(lines),
        text=True,
        stdout=subprocess.PIPE,
    )
    if res.returncode not in (0, 1):  # 130 = aborted with Esc/Ctrl-C
        sys.exit(0)
    out = res.stdout.strip("\n")
    return out.split("\n") if out else []


def artists_str(item):
    arts = item.get("artists") or []
    names = [a.get("name", "") for a in arts if a.get("name")]
    return ", ".join(names) or "?"


def song_line(item):
    """Format a track dict as 'Title — Artist\\tvideoId'."""
    vid = item.get("videoId")
    if not vid:
        return None
    return f"{item.get('title', '?')} — {artists_str(item)}\t{vid}"


def search_lives(query, n=25):
    """Search regular YouTube and keep only ongoing live streams.

    Lives aren't in the YT Music catalog, so this goes through yt-dlp's flat
    search and filters by live_status (avoids resolving every result).
    """
    res = subprocess.run(
        [
            "yt-dlp", "-q", "--no-warnings", "--flat-playlist",
            "--print", "%(live_status)s\t%(id)s\t%(title)s",
            f"ytsearch{n}:{query}",
        ],
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
    items = []
    for line in res.stdout.splitlines():
        parts = line.split("\t", 2)
        if len(parts) == 3 and parts[0] == "is_live":
            items.append((parts[1], parts[2]))  # (id, title)
    return items


def pick_video_ids(yt, authed):
    """Top menu -> returns (video_ids, is_live) to play (or exits).

    `authed`: library options (Minhas playlists / Curtidas) only show when
    logged in; search and lives work unauthenticated too.
    """
    menu = ["Buscar músicas", "Buscar playlists", "Lives"]
    if authed:
        menu += ["Minhas playlists", "Curtidas"]
    choice = fzf(menu, prompt="YouTube Music > ")
    if not choice:
        sys.exit(0)
    choice = choice[0]

    if choice == "Buscar músicas":
        query = input("Buscar música: ").strip()
        if not query:
            sys.exit(0)
        results = yt.search(query, filter="songs")
        lines = [l for l in (song_line(r) for r in results) if l]
        picked = fzf(lines, multi=True, prompt="músicas > ")
        return [p.split("\t", 1)[1] for p in picked], False

    if choice == "Buscar playlists":
        query = input("Buscar playlist: ").strip()
        if not query:
            sys.exit(0)
        results = yt.search(query, filter="playlists")
        lines = []
        for r in results:
            pid = r.get("playlistId") or r.get("browseId")
            if pid:
                lines.append(f"{r.get('title', '?')}\t{pid}")
        picked = fzf(lines, prompt="playlist > ")
        if not picked:
            sys.exit(0)
        return tracks_of_playlist(yt, picked[0].split("\t", 1)[1]), False

    if choice == "Lives":
        query = input("Buscar live (ex: lofi girl): ").strip()
        if not query:
            sys.exit(0)
        items = search_lives(query)
        if not items:
            die("nenhuma live ao vivo encontrada")
        lines = [f"🔴 {title}\t{vid}" for vid, title in items]
        picked = fzf(lines, prompt="lives > ")
        if not picked:
            sys.exit(0)
        return [picked[0].split("\t", 1)[1]], True

    if choice == "Minhas playlists":
        results = yt.get_library_playlists(limit=200)
        lines = []
        for r in results:
            pid = r.get("playlistId")
            if pid:
                lines.append(f"{r.get('title', '?')}\t{pid}")
        picked = fzf(lines, prompt="minhas playlists > ")
        if not picked:
            sys.exit(0)
        return tracks_of_playlist(yt, picked[0].split("\t", 1)[1]), False

    if choice == "Curtidas":
        tracks = yt.get_liked_songs(limit=500).get("tracks", [])
        lines = [l for l in (song_line(t) for t in tracks) if l]
        picked = fzf(lines, multi=True, prompt="curtidas > ")
        return [p.split("\t", 1)[1] for p in picked], False

    sys.exit(0)


def tracks_of_playlist(yt, playlist_id):
    data = yt.get_playlist(playlist_id, limit=None)
    return [t["videoId"] for t in data.get("tracks", []) if t.get("videoId")]


def stop_joke_music():
    """Send mpv `quit` to the nvim background-music socket (best effort)."""
    if not JOKE_SOCKET.exists():
        return
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
            s.settimeout(1)
            s.connect(str(JOKE_SOCKET))
            s.sendall((json.dumps({"command": ["quit"]}) + "\n").encode())
    except OSError:
        pass  # nvim closed it between the check and now, or jokes off


def ytm_ipc(command, *, read=False):
    """Send one JSON command to the background mpv daemon. Returns reply data
    when `read`, else None. Silent if the daemon isn't up."""
    if not YTM_SOCKET.exists():
        return None
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
            s.settimeout(2)
            s.connect(str(YTM_SOCKET))
            s.sendall((json.dumps({"command": command}) + "\n").encode())
            if not read:
                return None
            buf = b""
            while b"\n" not in buf:
                chunk = s.recv(4096)
                if not chunk:
                    break
                buf += chunk
            for line in buf.split(b"\n"):
                if not line:
                    continue
                msg = json.loads(line)
                if "data" in msg or msg.get("error"):
                    return msg.get("data")
    except (OSError, json.JSONDecodeError):
        return None


def _connectable():
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
            s.settimeout(1)
            s.connect(str(YTM_SOCKET))
            return True
    except OSError:
        return False


def start_daemon():
    """Spawn a detached, headless, idle mpv with the IPC socket. Survives the
    launching terminal/nvim (new session, no controlling tty)."""
    YTM_SOCKET.parent.mkdir(parents=True, exist_ok=True)
    # yt-dlp raw options through mpv's ytdl_hook. mpv splits this list on commas,
    # so every value must be comma-free (tv_embedded is a single client on purpose).
    raw = [f"extractor-args=youtube:player_client={PLAYER_CLIENT}"]
    # Cookies OFF by default: playback works logged-out and cookies break the
    # tv_embedded client. Set YTMUSIC_COOKIES=firefox (or chrome/...) to opt in.
    cookies = os.environ.get("YTMUSIC_COOKIES", "none")
    if cookies and cookies.lower() != "none":
        raw.append(f"cookies-from-browser={cookies}")
    cmd = [
        "mpv",
        "--no-video",
        "--no-terminal",
        "--force-window=no",
        "--idle=yes",               # stay alive with an empty queue
        "--keep-open=no",
        f"--input-ipc-server={YTM_SOCKET}",
        "--script-opts=ytdl_hook-ytdl_path=yt-dlp",
        "--ytdl-format=bestaudio/best",
        "--ytdl-raw-options=" + ",".join(raw),
    ]
    devnull = subprocess.DEVNULL
    subprocess.Popen(
        cmd,
        stdin=devnull,
        stdout=devnull,
        stderr=devnull,
        start_new_session=True,  # detach: own process group, no parent kill
    )
    # Wait for the IPC socket to come up.
    for _ in range(50):
        if YTM_SOCKET.exists() and _connectable():
            return
        time.sleep(0.1)


def play(video_ids, live=False):
    """Load the selection into the background daemon, replacing its queue.

    `live`: lives need YouTube's default client, but the daemon globally forces
    tv_embedded (required for normal tracks). So per-file we clear ytdl-raw-options
    for live entries — mpv's loadfile applies these options only to that entry.
    """
    if not (YTM_SOCKET.exists() and _connectable()):
        start_daemon()
    urls = [WATCH_URL.format(v) for v in video_ids]
    for i, url in enumerate(urls):
        mode = "replace" if i == 0 else "append"
        if live:
            # 4th/5th loadfile args: index (-1 = default), per-entry options.
            ytm_ipc(["loadfile", url, mode, -1, "ytdl-raw-options="])
        else:
            ytm_ipc(["loadfile", url, mode])
    ytm_ipc(["set_property", "pause", False])


# --- control subcommands (used by the CLI and the nvim keymaps) -------------
def cmd_pause():
    ytm_ipc(["cycle", "pause"])


def cmd_next():
    ytm_ipc(["playlist-next"])


def cmd_prev():
    ytm_ipc(["playlist-prev"])


def cmd_vol(delta):
    ytm_ipc(["add", "volume", delta])


def cmd_stop():
    ytm_ipc(["quit"])
    try:
        YTM_SOCKET.unlink()
    except OSError:
        pass


CONTROLS = {
    "pause": cmd_pause,
    "next": cmd_next,
    "prev": cmd_prev,
    "stop": cmd_stop,
}


def load_auth():
    """Load the browser-auth headers, repairing the `authorization` header.

    ytmusicapi only treats headers as BROWSER auth when an `authorization`
    SAPISIDHASH header is present, but many Firefox requests omit it. Since the
    cookie carries the SAPISID, recompute it here (ytmusicapi rebuilds it per
    request anyway, so the timestamp doesn't matter) — otherwise it misreads the
    file as OAuth and demands oauth_credentials.
    """
    if not AUTH_FILE.exists():
        return None  # unauthenticated: search-only
    data = json.loads(AUTH_FILE.read_text())
    has_auth = any(k.lower() == "authorization" for k in data)
    cookie = next((v for k, v in data.items() if k.lower() == "cookie"), None)
    if not has_auth and cookie:
        origin = next(
            (v for k, v in data.items() if k.lower() in ("origin", "x-origin")),
            "https://music.youtube.com",
        )
        # Imported lazily so control subcommands don't pay for ytmusicapi.
    from ytmusicapi.helpers import get_authorization, sapisid_from_cookie

    data["authorization"] = get_authorization(
            sapisid_from_cookie(cookie) + " " + origin
        )
    return data


def pick_and_play():
    from ytmusicapi import YTMusic  # lazy: only the picker needs it

    auth = load_auth()
    yt = YTMusic(auth) if auth else YTMusic()

    video_ids, live = pick_video_ids(yt, authed=auth is not None)
    if not video_ids:
        die("nada selecionado")

    stop_joke_music()       # don't overlap the dashboard background music
    play(video_ids, live=live)  # detached daemon: keeps playing after we exit


def main():
    # Control subcommands talk to the running daemon and return immediately;
    # no args -> open the picker.
    if len(sys.argv) > 1:
        action = sys.argv[1]
        if action == "vol" and len(sys.argv) > 2:
            cmd_vol(int(sys.argv[2]))
            return
        fn = CONTROLS.get(action)
        if not fn:
            die(f"comando desconhecido: {action} (use pause|next|prev|stop|vol N)")
        fn()
        return
    pick_and_play()


if __name__ == "__main__":
    main()
