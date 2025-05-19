-- plugins/trouble.lua
return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble preview_float toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    config = function()
        require("trouble").setup({
            modes = {
                preview_float = {
                    mode = "diagnostics",
                    preview = {
                        type = "float",
                        relative = "editor",
                        border = "rounded",
                        title = "Preview",
                        title_pos = "center",
                        position = { 0, -2 },
                        size = { width = 0.3, height = 0.3 },
                        zindex = 200,
                    },
                },
            },
        })
    end
}
-- return {
--     "folke/trouble.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional but recommended
--     cmd = { "TroubleToggle", "Trouble" },
--     keys = {
--         { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
--         { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
--         { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
--         { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },
--         { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List" },
--         { "gR",         "<cmd>TroubleToggle lsp_references<cr>",        desc = "LSP References" },
--     },
--     config = function()
--         require("trouble").setup({
--             position = "bottom", -- or "right"
--             height = 10,
--             icons = true,
--             use_diagnostic_signs = true,
--         })
--     end
-- }
