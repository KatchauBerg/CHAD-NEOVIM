return {
  "kiddos/gemini.nvim",
  config = function()
    require("gemini").setup({
      model_config = {
        model_id = "gemini-2.5-pro",
        temperature = 0.1,
        top_k = 128,
      },
      chat_config = {
        enabled = true,
      },
      hints = {
        enabled = true,
        hints_delay = 2000,
        insert_result_key = "<C-l>",
      },
      instruction = {
        enabled = true,
        menu_key = "<Leader>gm",
      },
    })
  end,
}
