local cmd = vim.cmd
-- See https://github.com/alvan/vim-closetag for settings
cmd("let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx'")
cmd("let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.xml'")
cmd("let g:closetag_filetypes = 'html,xhtml,phtml,xml'")
cmd("let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx,xml'")
cmd("let g:closetag_emptyTags_caseSensitive = 1")
cmd("let g:closetag_regions = {'typescript.tsx': 'jsxRegion,tsxRegion','javascript.jsx': 'jsxRegion',}")
cmd("let g:closetag_shortcut = '>'")
cmd("let g:closetag_close_shortcut = '<leader>>'")
