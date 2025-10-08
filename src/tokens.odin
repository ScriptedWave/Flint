package main

TokenKind :: enum {
    Identifier,
    Keyword,
    Punctuator,
    Operator,
    Literal
}

Token :: struct {
    kind: TokenKind,
    value: string
}

token_new :: proc(kind: TokenKind, value: string) -> Token {
    return Token{ kind = kind, value = value }
}