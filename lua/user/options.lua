local cmd = vim.cmd

local options = {
  backup = false,                          -- Don't use backup files
  clipboard = "unnamedplus",               -- Use system clipboard
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  encoding = "utf-8",                      -- Endcoding displayed
  ruler =  true,                           -- Show the cursor position at all times
  softtabstop = 2,                         -- 2 space
  tabstop = 2,                             -- 2 space
  shiftwidth = 2,                          -- 2 width
  expandtab = true,                        -- Spaces > tabs
  smartindent = true,                      -- Indent smartly
  smarttab = true,                         -- Tab smart, tab s-mart
  smartcase = true,                        -- Unless uppercase explicitly mentioned
  splitbelow = true,                       -- Force all horizontal splits to go below current window
  splitright = true,                       -- Force all vertical splits to go to the right of current window                        --
  pumheight = 10,                          -- Popup menu height
  number = true,                           -- Show current line number
  relativenumber = true,                   -- Show relative line number
  showcmd = true,                          -- Show current command
  wildmode = "longest:list,full",          -- Autocomplete
  showmatch = true,                        -- highlight matching braces
  hlsearch = true,                         -- Highlight search
  ignorecase = true,                       -- Ignore case while searching
  wrap = false,                            -- Don't wrap text
  swapfile = false,                        -- Dont create .swp or any other file after buffer
  laststatus = 2,                          -- Always show statusbar
  showmode = false,                        -- Hide mode (lightline shows mode)
  scrolloff = 8,                           -- Minimum space on bottom/top of window
  backup = false,                          -- Backup file is immediately deleted
  incsearch = true,                        -- Increamental search
  inccommand = "nosplit",                  -- Live substitution
  termguicolors = true,                    -- Terminal gui color
  -- foldmethod = "syntax",                   -- fold function in program
  timeoutlen = 500,                        -- Which key timeoutlen
  colorcolumn = "9999",                    -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  signcolumn = "yes",                      -- Always show the signcolumn, otherwise it would shift the text each time
  undofile = true,                         -- Undo Settings 
  background = "dark",
}

for k, v in pairs(options) do 
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"

cmd "syntax on"
cmd "set whichwrap+=<,>,[,],h,l"
cmd [[set iskeyword+=-]]
cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

