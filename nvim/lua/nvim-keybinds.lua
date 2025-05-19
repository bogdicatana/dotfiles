-- lua/cheatsheet.lua

local cheatsheet_lines = {
    "== Neovim Cheatsheet ==",
    "",
    "-- Modes --",
    "  Esc             Normal mode",
    "  i               Insert mode",
    "  v / V / Ctrl+v  Visual, Line, Block modes",
    "  :               Command mode",
    "",
    "-- Editing --",
    "  i / a / o / O   Insert, Append, Open line below/above",
    "  r<char>         Replace single character",
    "  R               Replace mode (overwrite)",
    "",
    "-- Undo / Redo --",
    "  u               Undo",
    "  Ctrl + R        Redo",
    "",
    "-- Delete / Cut --",
    "  dd              Delete line",
    "  d{motion}       Delete by motion (dw, d$, etc.)",
    "  x / X           Delete char under/before cursor",
    "",
    "-- Copy / Paste --",
    "  yy / y{motion}  Yank line / by motion",
    "  p / P           Paste after / before cursor",
    "",
    "-- Search --",
    "  /pattern        Search forward",
    "  ?pattern        Search backward",
    "  n / N           Repeat search (forward/backward)",
    "",
    "-- Movement --",
    "  h j k l         Left, Down, Up, Right",
    "  w / b           Next / Previous word",
    "  0 / $           Start / End of line",
    "  gg / G          Start / End of file",
    "  :n              Go to line number n",
    "",
    "-- Indenting --",
    "  >> / <<         Indent / De-indent line",
    "  > / < (visual)  Indent / De-indent selection",
    "",
    "-- File & Exit --",
    "  :w / :q         Save / Quit",
    "  :wq / ZZ        Save and Quit",
    "  :q!             Quit without saving",
    "",
    "-- Persistence --",
    "  Space + ql      Open last state",
    "  Space + qS      Choose which last state",
    "-- Search files --",
    "  Space + ff      Find files",
    "  Space + fg      Live grep",
    "-- Other --",
    "  .               Repeat last change",
    "  Space + t       Open terminal (fish)",
    "  Space + e       Open file tree",
    "  H / L           Prev / Next buffer",
    "  Ctrl + o / i    Jump older / newer cursor position",
}

local function show_cheatsheet()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, cheatsheet_lines)

    local width = 60
    local max_height = vim.o.lines - 4
    local desired_height = #cheatsheet_lines + 2
    local height = math.min(desired_height, max_height)

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = "rounded",
        style = "minimal",
    })

    -- Apply highlights using Catppuccin highlight groups
    for i, line in ipairs(cheatsheet_lines) do
        if line:match("^==") then
            vim.api.nvim_buf_add_highlight(buf, -1, "Title", i - 1, 0, -1)
        elseif line:match("^%-%-") then
            vim.api.nvim_buf_add_highlight(buf, -1, "Type", i - 1, 0, -1)
        elseif line:match("^  ") then
            local key_end = line:find("%s%s+")
            if key_end then
                vim.api.nvim_buf_add_highlight(buf, -1, "Keyword", i - 1, 2, key_end)
                vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, key_end, -1)
            end
        end
    end

    -- Allow closing with 'q'
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
end

return {
    show = show_cheatsheet
}
