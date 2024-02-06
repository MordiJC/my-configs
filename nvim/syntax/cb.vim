" Vim syntax file
" Language: coreboot devicetree
" Maintainer: Jakub Czapiga
" Latest Revision 15 August 2023

if exists("b:current_syntax")
  finish
endif

" Comments
syn keyword cbTodo containedin=cbComment contained TODO FIXME XXX NOTE
syn match cbComment "#.*$" contains=cbTodo

" Values
syn match cbRawValue '\(0x\)\{,1}[0-9a-fA-F]\+'
syn match cbHexPath '[0-9a-fA-F\.]\+'

" Symbols
syn match cbOperator '=\||'

" Keywords
syn keyword cbTypeKeyword chip device end
syn keyword cbTypeKeyword alias ops use ref as register
syn keyword cbTypeKeyword fw_config field option

syn keyword cbSecondaryKeyword pci pnp i2c cpu_cluster cpu domain generic
syn keyword cbSecondaryKeyword mmio spi usb gpio mdio irq drq io probe

syn keyword cbBool on off
syn keyword cbStatus hidden mandatory

syn keyword cbRelationKeyword inherit subsystemid

syn keyword cbSMBiosKeyword smbios_slot_desc smbios_dev_info

syn match cbTypePath '\(\w\+/\)*\(\w\+\)'

syn region cbString start='""' end='""' oneline

syn include @langC syntax/c.vim
unlet b:current_syntax
syn region cbRegisterCLang matchgroup=cbRegister start='"' end='"' contains=@langC keepend

hi def link cbTodo             Todo
hi def link cbComment          Comment
hi def link cbRawValue         Number
hi def link cbHexPath          Constant
hi def link cbTypeKeyword      Type
hi def link cbSecondaryKeyword StorageClass
hi def link cbBool             Boolean
hi def link cbStatus           Boolean
hi def link cbRelationKeyword  Label
hi def link cbSMBiosKeyword    Keyword
hi def link cbOperator         Operator
hi def link cbTypePath         String
hi def link cbString           String

let b:current_syntax = "cb"
autocmd BufNewFile,BufRead *.cb setlocal filetype=cb
