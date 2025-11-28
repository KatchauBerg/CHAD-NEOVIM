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
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            controls = {
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                },
            },
        })

        dap.adapters.cppdbg = {
            type = 'executable',
            command = '/home/dev2/.local/share/nvim/mason/bin/codelldb', 
            name = 'codelldb',
        }

        dap.configurations.cpp = {
            {
                name = "Launch C++ Executável",
                type = "cppdbg", -- DEVE CORRESPONDER AO ADAPTER ID ACIMA
                request = "launch",
                program = function()
                    -- Pergunta ao usuário o caminho do binário compilado
                    return vim.fn.input('Caminho para o executável: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = true,
            },
        }

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        local function dap_launch()
            dapui.open()
            dap.run_last() 
        end

        vim.keymap.set('n', '<Leader><F6>', dap_launch, { desc = 'DAP: Iniciar/Lançar Sessão' })
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Continuar/Parar' })
        vim.keymap.set('n', '<Leader>c', dap.terminate, { desc = 'DAP: Parar Sessão' })
        
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })

        vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
        vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = 'DAP UI: Toggle Interface' })

    end,
}
