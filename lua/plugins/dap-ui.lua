return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- 1. Configuração da UI (Visual)
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
            controls = {
                enabled = true,
                element = "repl",
            },
        })

        -- 2. Virtual text nos breakpoints/valores
        require("nvim-dap-virtual-text").setup()

        -- 3. Configuração do Adaptador
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
                args = { "--port", "${port}" },
            }
        }

        -- 4. Configuração de Lançamento para C e C++
        dap.configurations.cpp = {
            {
                name = "Launch C++ Executável",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Caminho para o executável: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp

        -- 5. Listeners (Automação da UI)
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- 6. Keymaps
        vim.keymap.set('n', '<F5>',       dap.continue,          { desc = 'DAP: Iniciar/Continuar' })
        vim.keymap.set('n', '<Leader>c',  dap.terminate,         { desc = 'DAP: Parar Sessão' })
        vim.keymap.set('n', '<F10>',      dap.step_over,         { desc = 'DAP: Step Over' })
        vim.keymap.set('n', '<F11>',      dap.step_into,         { desc = 'DAP: Step Into' })
        vim.keymap.set('n', '<F12>',      dap.step_out,          { desc = 'DAP: Step Out' })
        vim.keymap.set('n', '<Leader>b',  dap.toggle_breakpoint, { desc = 'DAP: Breakpoint' })
        vim.keymap.set('n', '<Leader>du', dapui.toggle,          { desc = 'DAP UI: Abrir/Fechar' })
    end,
}
