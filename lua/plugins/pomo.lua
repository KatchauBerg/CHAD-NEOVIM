return {
  "epwalsh/pomo.nvim",
  -- cond = not vim.g.vscode,
  version = "*",
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  dependencies = { "rcarriga/nvim-notify" },
  opts = {
    update_interval = 1000,

    notifiers = {
      -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
      {
        name = "Default",
        opts = {
          sticky = true,

          -- Configure the display icons:
          title_icon = "󱎫",
          text_icon = "󰄉",
          -- Replace the above with these if you don't have a patched font:
          title_icon = "⏳",
          text_icon = "⏱️",
        },
      },

      -- The "System" notifier sends a system notification when the timer is finished.
      -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
      { name = "System" },

      -- You can also define custom notifiers by providing an "init" function instead of a name.
      -- See "Defining custom notifiers" below for an example 👇
      -- { init = function(timer) ... end }
    },

    -- Override the notifiers for specific timer names.
    timers = {
      -- For example, use only the "System" notifier when you create a timer called "Break",
      -- e.g. ':TimerStart 2m Break'.
      Break = {
        { name = "System" },
      },
    },
    -- You can optionally define custom timer sessions.
    sessions = {
      -- Example session configuration for a session called "pomodoro".
      work = {
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
      },
    },
  },
}
