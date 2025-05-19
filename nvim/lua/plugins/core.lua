-- plugins/core.lua
return {
    -- Session persistence
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        config = function()
            require("persistence").setup()
        end,
    },

    -- Which-Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        delay = function()
            return 0
        end,
        config = function()
            require("which-key").setup()
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Nvim Tree (file explorer)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        },
        config = function()
            require("nvim-tree").setup({
                view = { width = 30 },
                filters = { dotfiles = false },
                git = { enable = true },
            })
        end,
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Comment.nvim
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Toggle line comment" },
            { "gb", mode = { "n", "v" }, desc = "Toggle block comment" },
        },
        config = function()
            require("Comment").setup()
        end,
    },

    -- indent-blankline.nvim
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    }
}
