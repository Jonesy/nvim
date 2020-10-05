let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'reason': ['/Users/admin/LS/rls-macos/reason-language-server'],
    \ }

" enable autocomplete
let g:deoplete#enable_at_startup = 1
