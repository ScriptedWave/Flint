package main

import "core:unicode"
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
        ch, ok := peek(&self)
        if !ok {
            break;
        }

        switch {
            case ch == '(': { append(&tokens, tokenNew(.PuncLParen, "(")); eat(&self) }
            case ch == ')': { append(&tokens, tokenNew(.PuncRParen, ")")); eat(&self) }
            case ch == ':': { append(&tokens, tokenNew(.PuncColon, ":")); eat(&self) }
            case ch == ';': { append(&tokens, tokenNew(.PuncSemi, ";")); eat(&self) }
            case ch == '.': { append(&tokens, tokenNew(.PuncDot, ".")); eat(&self) }

            case unicode.is_letter(rune(ch)): {
                buffer: [dynamic]u8

                for true {
                    ch, ok := peek(&self)

                    if !ok || (!unicode.is_letter(rune(ch)) && !unicode.is_number(rune(ch)) && ch != '_') {
                        break
                    }

                    append(&buffer, ch)
                    eat(&self)
                }

                str := string(buffer[:])

                if str == "func" {
                    append(&tokens, tokenNew(.KeyFunc, string(buffer[:])))
                }
                else if str == "void" {
                    append(&tokens, tokenNew(.KeyVoid, string(buffer[:])))
                }
                else if str == "print" {
                    append(&tokens, tokenNew(.KeyPrint, string(buffer[:])))
                }
                else if str == "exit" {
                    append(&tokens, tokenNew(.KeyExit, string(buffer[:])))
                }
                else {
                    append(&tokens, tokenNew(.Identifier, string(buffer[:])))
                }
            }

            case unicode.is_number(rune(ch)): {
                buffer: [dynamic]u8

                for true {
                    ch, ok := peek(&self)

                    if !ok || (!unicode.is_number(rune(ch))) {
                        break
                    }

                    append(&buffer, ch)
                    eat(&self)
                }

                append(&tokens, tokenNew(.LitInt, string(buffer[:])))
            }

            case unicode.is_white_space(rune(ch)): {
                eat(&self)
            }

            case: {
                panic("Invalic character.")
            }
        }
    }

    return tokens[:]
}