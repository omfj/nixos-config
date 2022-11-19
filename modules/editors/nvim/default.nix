#
# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [

        # Syntax
        vim-nix
        vim-markdown

        # Quality of life
        vim-lastplace         # Opens document where you left it
        auto-pairs            # Print double quotes/brackets/etc.
        vim-gitgutter         # See uncommitted changes of file :GitGutterEnable

        # File Tree
	nerdtree              # File Manager - set in extraConfig to F6
	
        # Customization 
        wombat256-vim         # Color scheme for lightline
        srcery-vim            # Color scheme for text

        lightline-vim         # Info bar at bottom
	indent-blankline-nvim # Indentation lines
      ];

      extraConfig = ''
        let mapleader = " "
        set backspace=indent,eol,start
        set nu rnu
        set mouse=a
        set so=5
        syntax enable                             " Syntax highlighting
        colorscheme srcery                        " Color scheme text

        let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ }                                     " Color scheme lightline

        highlight Comment cterm=italic gui=italic " Comments become italic
        hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme
        
        " Nerdtree
        nnoremap <leader>e :NERDTreeToggle<CR>
        
        " Window Navigation with Ctrl-[hjkl]
        noremap <C-J> <C-W>j
        noremap <C-K> <C-W>k
        noremap <C-H> <C-W>h
        noremap <C-L> <C-W>l
      '';
    };
  };
}

