package main

import "core:fmt"

main :: proc() {
    filename := get_filename()
    content := get_file_content(filename)
    fmt.println(content)
}