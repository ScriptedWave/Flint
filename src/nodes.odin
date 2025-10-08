package main

NodeProgram :: struct {
    func: NodeFunction
}

NodeFunction :: struct {
    ident: string,
    scope: NodeScope
}

NodeScope :: struct {
    stmts: []NodeStmt
}

NodeStmt :: union {
    NodeStmtExit,
    NodeStmtPrint
}

NodeStmtExit :: struct {
    lit_int: string
}

NodeStmtPrint :: struct {
    lit_int: string
}
