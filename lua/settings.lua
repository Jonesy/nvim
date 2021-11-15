local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

g.mapleader = " "

cmd "syntax on"

opt("o", "clipboard","unnamedplus")            -- Use system clipboard
opt("o", "encoding", "utf-8")                  -- Endcoding displayed
opt("o", "ruler", true)                        -- Show the cursor position at all times
opt("o", "softtabstop", 2)                     -- 2 space
opt("o", "tabstop", 2)                         -- 2 space
opt("b", "shiftwidth", 2)                      -- 2 2 CHAINZ
opt("b", "expandtab", true)                    -- Spaces > tabs
opt("b", "smartindent", true)                  -- indent smartly
opt("o", "smarttab", true)                     -- Tab smart, tab s-mart
opt("o", "smartcase", true)                    -- unless uppercase explicitly mentioned
opt("o", "number", true)                       -- Show current line number
opt("o", "relativenumber", true)               -- Show relative line number
opt("o", "showcmd", true)                      -- Show current command
opt("o", "wildmode", "longest:list,full")      -- Autocomplete
opt("o", "showmatch", true)                    -- highlight matching braces
opt("o", "hlsearch", true)                     -- Highlight search
opt("o", "ignorecase", true)                   -- ignore case while searching
opt("o", "wrap", false)                        -- Don't wrap text
opt("o", "swapfile", false)                    -- Dont create .swp or any other file after buffer
opt("o", "laststatus", 2)                      -- Always show statusbar
opt("o", "showmode", false)                    -- Hide mode (lightline shows mode)
opt("o", "scrolloff", 5)                       -- Minimum space on bottom/top of window
opt("o", "backup", false)                      -- Backup file is immediately deleted
opt("o", "incsearch", true)                    -- Increamental search
opt("o", "inccommand", "nosplit")              -- Live substitution
opt("o", "termguicolors", true)                -- Terminal gui color
-- opt("o", "foldmethod", "syntax")               -- fold function in program
opt("o", "timeoutlen", 500)                    -- Which key timeoutlen
opt("w", "colorcolumn", "9999")                -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
opt("w", "signcolumn", "yes")                  -- Always show the signcolumn, otherwise it would shift the text each time
opt("b", "undofile", true)                     -- Undo Settings 
opt("o", "background", "dark")
