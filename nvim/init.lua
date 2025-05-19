vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = a
vim.o.updatetime = 300
vim.g.mapleader = " "
vim.opt.ww = '<,>,h,l,[,]'
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end,
    { desc = "load the session for the current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end,
    { desc = "select a session to load" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
    { desc = "load the last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end,
    { desc = "stop Persistence" })
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Show diagnostics in a floating window on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
vim.api.nvim_create_user_command("Cheatsheet", function()
    require("nvim-keybinds").show()
end, {})
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('belowright split | terminal fish')
end, { desc = "Open terminal (fish) at bottom" })

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function()
--         require("nvim-tree.api").tree.open()
--     end,
-- })

require("config.lazy")
require("ibl").setup()
