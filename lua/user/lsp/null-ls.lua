local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- local completion = null_ls.builtins.completion

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			only_local = "node_modules/.bin",
			extra_filetypes = { "html", "json", "toml", "solidity" },
			extra_args = {
				"--single-quote",
			},
		}),
		formatting.black.with({
			extra_args = {
				"--fast",
			},
		}),
		-- formatting.yapf,
		formatting.prettierd.with({
			filetypes = { "html", "json", "css", "yaml" },
			extra_filetypes = { "html", "json", "css", "yaml" },
		}),
		formatting.stylua.with({
			condition = function()
				return vim.fn.executable("stylua") > 0
			end,
		}),
		formatting.deno_fmt.with({
			condition = function(utils)
				return utils.root_has_file({ "deno.json" })
			end,
		}),
		formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}),
		diagnostics.eslint.with({
			only_local = "node_modules/.bin",
		}),
		diagnostics.flake8,
		-- completion.spell,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
