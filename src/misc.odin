package main

import "core:os"
import "core:fmt"

get_filename :: proc() -> string {
    args := os.args
    if len(args) < 2 && !os.exists(args[1]) {
        panic("Too few arguments.")
    }

    return args[1]
}

get_file_content :: proc(filename: string) -> string {
    data, ok := os.read_entire_file_from_filename(filename)
    return string(data)
}