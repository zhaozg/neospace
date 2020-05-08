if exists("b:current_syntax")
    finish
endif

syntax case ignore

syntax match LeaderSeperator /\s+/ contained
syntax match LeaderIdentifier /\(^\s*\|\s\{2,}\)\S\s/ contains=LeaderSeperator

highlight default link LeaderIdentifier  Type

let b:current_syntax = "leader"
