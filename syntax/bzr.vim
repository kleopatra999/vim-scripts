" Vim syntax file
" Language:     Bazaar (bzr) commit file
" Maintainer:   Dmitry Vasiliev <dima at hlabs dot spb dot ru>
" URL:          http://www.hlabs.spb.ru/vim/bzr.vim
" Revision:     $Id$
" Filenames:    bzr_log.*
" Version:      1.2
"
" Thanks:
"
"    Gioele Barabucci
"       for idea of diff highlighting

" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn include @Diff syntax/diff.vim

syn match bzrRemoved   "^removed:$" contained
syn match bzrAdded     "^added:$" contained
syn match bzrRenamed   "^renamed:$" contained
syn match bzrModified  "^modified:$" contained
syn match bzrUnchanged "^unchanged:$" contained
syn match bzrUnknown   "^unknown:$" contained
syn cluster Statuses contains=CONTAINED
syn region bzrRegion   start="^-\{14} This line and the following will be ignored -\{14}$" end="\%$" contains=@NoSpell,@Diff,@Statuses

" Synchronization.
syn sync clear
syn sync match bzrSync  grouphere bzrRegion "^-\{14} This line and the following will be ignored -\{14}$"me=s-1

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already.
" For version 5.8 and later: only when an item doesn't have highlighting yet.
if version >= 508 || !exists("did_bzr_syn_inits")
  if version <= 508
    let did_bzr_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink bzrRegion     Comment
  HiLink bzrRemoved    Constant
  HiLink bzrAdded      Identifier
  HiLink bzrModified   Special
  HiLink bzrRenamed    Special
  HiLink bzrUnchanged  Special
  HiLink bzrUnknown    Special

  delcommand HiLink
endif

let b:current_syntax = "bzr"
