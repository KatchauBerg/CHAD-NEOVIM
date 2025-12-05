# Troubleshooting: image.nvim & Tmux `allow-passthrough` Error

## Problem Description

When using `image.nvim` with the `kitty` backend inside Tmux, you may encounter the following error on startup, preventing the plugin from loading:

```
Failed to run `config` for image.nvim
.../image.nvim/lua/image/utils/logger.lua:280: tmux does not have allow-passthrough enabled
```

## Verification

This error persists even after:
1. Adding `set -g allow-passthrough on` to `~/.tmux.conf`.
2. Restarting the Tmux server (`tmux kill-server`).
3. Verifying the setting is active via the command line:
   ```bash
   tmux show -Apv allow-passthrough
   # Output: on
   ```
4. Running a debug script inside Neovim that successfully detects the "on" state.

## Solution (Workaround)

If the standard configuration steps fail, the issue is likely a race condition or environment mismatch within the plugin's check logic. The current workaround is to manually patch the plugin source code to bypass this check.

### Steps to Fix

1. **Locate the plugin file:**
   The file responsible for the check is usually located at:
   `~/.local/share/nvim/lazy/image.nvim/lua/image/utils/tmux.lua`

2. **Edit the file:**
   Open the file in your editor.

3. **Modify the `has_passthrough` variable:**
   Find the code block that looks like this (around line 3):

   ```lua
   local has_passthrough = false
   if is_tmux then
     local ok, result = pcall(vim.fn.system, { "tmux", "show", "-Apv", "allow-passthrough" })
     if ok and (result:sub(-3) == "on\n" or result:sub(-4) == "all\n") then has_passthrough = true end
   end
   ```

   **Replace it with:**

   ```lua
   local has_passthrough = true
   -- if is_tmux then
   --   local ok, result = pcall(vim.fn.system, { "tmux", "show", "-Apv", "allow-passthrough" })
   --   if ok and (result:sub(-3) == "on\n" or result:sub(-4) == "all\n") then has_passthrough = true end
   -- end
   ```

4. **Restart Neovim:**
   The error should now be resolved.

### Note on Updates
Since this modifies the plugin's source code locally, **updating the plugin (via Lazy or other managers) will overwrite this change**. If the error returns after an update, you will need to apply this patch again.
