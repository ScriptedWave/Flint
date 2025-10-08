package main

import "core:os"
import "core:fmt"

getFilename :: proc() -> string {
    args := os.args
    if len(args) < 2 && !os.exists(args[1]) {
        panic("Too few arguments.")
    }

    return args[1]
}

getFileContent :: proc(filename: string) -> string {
    data, ok := os.read_entire_file_from_filename(filename)
    return string(data)
}