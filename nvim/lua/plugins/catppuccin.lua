-- plugins/catppuccin.lua
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before all other plugins
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                },
                cmp = true,
                lsp_trouble = true,
                telescope = true,
                which_key = true,
                -- add more plugin integrations if needed
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
