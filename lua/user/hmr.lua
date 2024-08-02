---This is an experimental first attempt at writing my own NeoVim plugin, which
---pings a URL at a specified location with the file that was updated
---@class (exact) hmr.setupOptions
---@field file_types? table<string>
---@field config_name? string
---
---Expected `hmr.json` file composition
---@class (exact) hmr.jsonConfig
---@field host string
---@field fileTypes table<string>
---@field notifyUrl string

local M = {}

M.file_types = { "*.css", "*.js" }
M.config_name = "hmr.json"

--- Custom file change notifier
---
--- Looks for a config file at project root
---@usage >json
--- {
---   "fileTypes": ["*.css", "*.js"],
---   "method": "curl",
---   "host": "http://localhost:3000",
---   "endpoint": "/_hmr"
--- }
---
---@usage >lua
--- require("hmr").setup({
---   file_types = { "*.scss", "*.ts" },
--- })
---
--- @param opts? hmr.setupOptions
M.setup = function(opts)
  opts = opts or {}
  M.file_types = vim.tbl_deep_extend("force", M.file_types, opts.file_types or {})
  if opts.config_name ~= nil then
    M.config_name = opts.config_name
  end
  local has_config = vim.fs.root(vim.fn.getcwd(), M.config_name)
  local hmr_group = vim.api.nvim_create_augroup("HMR", {
    clear = true,
  })
  if has_config ~= nil then
    vim.notify("Connected to HMR", vim.log.levels.INFO, {})
    ---@type hmr.jsonConfig
    local settings = vim.fn.json_decode(vim.fn.readfile(M.config_name))
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = M.file_types,
      desc = "Runs a POST curl to an HMR service",
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        local cwd = vim.fn.getcwd()
        local changed = filename:gsub(cwd, "")
        vim.system({
          "curl",
          "-X",
          "POST",
          "-d",
          "'name=" .. changed .. "'",
          settings.host .. settings.notifyUrl,
        }, { text = true }, function() end)
      end,
      group = hmr_group,
    })
  end
end

return M
