//
//  main.swift
//  TestSwiftRepl
//
//  Swift REPL terminal application.

import Foundation
import SwiftLLDB

SBDebugger.setUp()
let d = SBDebugger()
do {
    try d.runREPL(.Swift, options: "")
} catch {
    print("REPL failure: \(error)")
}
SBDebugger.tearDown()
