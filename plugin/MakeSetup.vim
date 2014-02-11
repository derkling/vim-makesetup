" MakeSetup plugin for VIM
"
" Copyright 2014, Patrick Bellasi <derkling@gmail.com>
"
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License version 2 as
" published by the Free Software Foundation.
"
" This plugin allows to setup a Makefile based compilation by specifying:
" - the top-level Makefile to use
" - the Makefile target
" - the make command to issue
"
" All the collected informations are used to properly setup makeprg
" such that the usual :make command could be used to trigger compilation

if &cp || v:version < 702 || (exists('g:loaded_make_parent') && g:loaded_make_parent)
	finish
endif
let g:loaded_make_parent = 1

" Set Makefile
function! SetMakeMakefile()
	let s:parent_makefile = findfile('Makefile', '.;')
	echom 'Parent Makefile path: '.s:parent_makefile
	let w:make_makefile = input('Enter Makefile path: ', s:parent_makefile, 'file')
	redraw | echo 'Using Makefile [' . w:make_makefile . ']'
	let w:make_folder = substitute(w:make_makefile, '/Makefile', '', '')
	echom 'Makefile folder: ' . w:make_folder
endfunction

" Set Makefile target
function! SetMakeTarget()
	let w:make_target = input('Enter Makefile target: ', 'all', 'file')
	redraw | echo 'Makefile target set to [' . w:make_target . ']'
endfunction

" Set Make command
function! SetMakeCommand()
	let w:make_command = input('Enter Make command: ', 'make')
	redraw | echo 'Make command set to [' . w:make_command . ']'
	let l:command_line = w:make_command . ' -C ' . w:make_folder . ' ' . w:make_target
	let &makeprg = l:command_line
	echom 'Make command line set to: ' . l:command_line
endfunction

" Run Make using configured Makefile and target
function! CompileParent()
	if ! exists('w:make_folder')
		call SetMakeMakefile()
	endif
	if ! exists('w:make_target')
		call SetMakeTarget()
	endif
	if ! exists('w:make_command')
		call SetMakeCommand()
	endif
	wa
	make
endfunction

" Setup mapping (if required)
if !exists('g:make_parent_no_mappings')
	noremap <script> <silent> <Leader>smp :call SetMakeMakefile()<CR>
	noremap <script> <silent> <Leader>smt :call SetMakeTarget()<CR>
	noremap <script> <silent> <Leader>smc :call SetMakeCommand()<CR>
	noremap <script> <silent> <Leader>m :call CompileParent()<CR>
endif

" vim: et ts=2 sts=2 sw=2
