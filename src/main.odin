package main

import "core:fmt"

main :: proc() {
    filename := getFilename()
    content := getFileContent(filename)
    lex(content)
}