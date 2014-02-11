# MakeSetup.vim

A simple plugin for vim that allows you to properly setup a Makefile based
compilation environment.

## Installation

### Basic Brute-Force Install

Copy `MakeSetup.vim` to your `~/.vim/plugin` directory.

### Pathogen

Checkout the github repository to the
[Pathogen](https://github.com/derkling/vim-makesetup) directory.

    cd ~/.vim/bundle
    git clone https://github.com/derkling/vim-makesetup.git


## Mappings

The default mappings are:

    noremap <script> <silent> <Leader>smp :call SetMakeMakefile()<CR>
    noremap <script> <silent> <Leader>smt :call SetMakeTarget()<CR>
    noremap <script> <silent> <Leader>smc :call SetMakeCommand()<CR>
    noremap <script> <silent> <Leader>m :call CompileParent()<CR>

You can prevent these mappings by setting `g:make_setup_no_mappings` in your
`.vimrc` and then remap them if you want--both `SetMakeMakefile`,
`SetMakeTarget`, `SetMakeCommand` and `MakeTarget` are global functions. I
imagine the names of the functions are self-explanatory.

