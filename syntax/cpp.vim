"syn match    cCustomParen    "?=(" contains=cParen,cCppParen
"syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
"syn match    cCustomScope    "::"
"syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
"hi def link cCustomFunc  Function
""hi def link cCustomClass Function 
"hi def cCustomClass gui=bold guifg=#4dc7ae
"syn match typedefSuffix     '\a\+'
"syn match cppType "\<type_\w\+\>"
"syn match    custonkey    "auto"

hi CocSemMacro guifg=#4dc7ae
hi CocSemType guifg=#4dc7ae
hi CocSemDeduced guifg=#569CD6
"hi CocSemDefaultLibrary guifg=#dadada
hi CocSemEnum guifg=#4dc7ae
hi CocSemEnumMember guifg=#B5CEA8
hi CocSemComment guifg=#66666b
