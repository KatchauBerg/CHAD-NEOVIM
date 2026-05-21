return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<F5>",       function() require("dap").continue() end,          desc = "DAP: Start/Continue" },
    { "<F10>",      function() require("dap").step_over() end,         desc = "DAP: Step Over" },
    { "<F11>",      function() require("dap").step_into() end,         desc = "DAP: Step Into" },
    { "<F12>",      function() require("dap").step_out() end,          desc = "DAP: Step Out" },
    { "<Leader>b",  function() require("dap").toggle_breakpoint() end, desc = "DAP: Breakpoint" },
    { "<Leader>du", function() require("dapui").toggle() end,          desc = "DAP UI: Toggle" },
    { "<Leader>c",  function() require("dap").terminate() end,         desc = "DAP: Stop" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
      controls = { enabled = true, element = "repl" },
    })

    require("nvim-dap-virtual-text").setup()

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch C++ Executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
  end,
}
