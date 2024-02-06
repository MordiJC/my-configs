syn match cType "\<[a-zA-Z_]\w*_t\>"
syn match Label "\v((struct|union|enum)\s+)@<=([a-zA-Z_]\w*)" display
syn match cType "typedef"
syn match cType "\<[uis]\(8\|16\|32\|64\|128\)\>"
syn match cConstant "\v\w@<!(\u|_+[A-Z0-9])[A-Z0-9_]*\w@!"
