local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local handlers = require("user.lsp.handlers")
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  -- -- specific configs for certain LSPs
  -- if server.name == "jsonls" then
	 -- 	local jsonls_opts = require("user.lsp.settings.jsonls")
	 -- 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  -- end
  --
	 if server.name == "sumneko_lua" then
     local sumneko_opts = require("user.lsp.settings.sumneko_lua"    )
	 	 opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

  server:setup(opts)
end)
