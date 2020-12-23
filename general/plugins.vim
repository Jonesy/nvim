" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " Syntax
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " Plug 'preservim/nerdcommenter'
  Plug 'tpope/vim-repeat'
  Plug 'suy/vim-context-commentstring'
  Plug 'jiangmiao/auto-pairs'
  Plug 'reasonml-editor/vim-reason-plus'
  Plug 'mattn/emmet-vim'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  " Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  Plug 'alvan/vim-closetag'
  Plug 'brooth/far.vim'
  Plug 'sheerun/vim-polyglot'

  " (Optional) Multi-entry selection UI.
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'peitalin/vim-jsx-typescript'
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'airblade/vim-rooter'

  " Layout
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  Plug 'voldikss/vim-floaterm'
  Plug 'liuchengxu/vim-which-key'
  
  " Languages
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'leafgarland/typescript-vim'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'

  " Themes
  Plug 'dracula/vim', { 'as': 'dracula' }

  " Language server extras
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
