package main

TokenKind :: enum {
    Identifier,
    KeyFunc,
    KeyVoid,
    KeyPrint,
    KeyExit,
    PuncLParen,
    PuncRParen,
    PuncColon,
    PuncSemi,
    PuncDot,
    LitInt,
}

Token :: struct {
    kind: TokenKind,
    value: string
}

tokenNew :: proc(kind: TokenKind, value: string) -> Token {
    return Token{ kind = kind, value = value }
}