package main

import "core:fmt"

lex :: proc(src: string) -> []Token {

    Lexer :: struct {
        src: string,
        idx: uint
    }

    eat :: proc(self: ^Lexer) -> u8 {
        tmp := self.src[self.idx]
        self.idx += 1
        return tmp
    }

    peek :: proc(self: ^Lexer, amt: uint = 0) -> (u8, bool) {
        if self.idx + amt >= len(self.src) { return 0, false }
        return self.src[self.idx + amt], true
    }

    self := Lexer{ src = src, idx = 0 }
    tokens: [dynamic]Token

    for true {
        if _, ok := peek(&self); !ok {
            break;
        }

        ch, _ := peek(&self)

        switch ch {
            case '(': { append(&tokens, tokenNew(.PuncLParen, "(")); eat(&self) }
            case ')': { append(&tokens, tokenNew(.PuncRParen, ")")); eat(&self) }
            case ':': { append(&tokens, tokenNew(.PuncColon, ":")); eat(&self) }
            case ';': { append(&tokens, tokenNew(.PuncSemi, ";")); eat(&self) }
            case '.': { append(&tokens, tokenNew(.PuncDot, ".")); eat(&self) }
            case: { eat(&self) }
        }
    }

    return tokens[:]
}