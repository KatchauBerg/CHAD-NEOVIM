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

        -- 2. Configuração do Adaptador (O Cérebro)
        -- Mudamos para 'server' pois o codelldb funciona melhor assim
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                -- CAMINHO DINÂMICO: Usa o diretório padrão do Mason
                command = vim.fn.stdpath("data") .. '/mason/bin/codelldb', 
                args = {"--port", "${port}"},
            }
        }

        -- 3. Configuração de Lançamento (Como rodar o C++)
        dap.configurations.cpp = {
            {
                name = "Launch C++ Executável",
                type = "codelldb", -- TEM QUE SER IGUAL AO NOME DO ADAPTER ACIMA
                request = "launch",
                program = function()
                    return vim.fn.input('Caminho para o executável: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false, -- Geralmente false é melhor para ir direto ao main ou breakpoint
            },
        }

        -- 4. Listeners (Automação da UI)
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- 5. Keymaps (Seus atalhos)
        local function dap_launch()
            -- Tenta rodar a ultima sessão, se não existir, começa uma nova
            if dap.session() then
                dap.continue()
            else
                dap.continue() 
            end
        end

        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Iniciar/Continuar' })
        vim.keymap.set('n', '<Leader>c', dap.terminate, { desc = 'DAP: Parar Sessão' })
        
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over (Pular linha)' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into (Entrar na função)' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out (Sair da função)' })

        vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'DAP: Breakpoint' })
        vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = 'DAP UI: Abrir/Fechar Manualmente' })
    end,
}
