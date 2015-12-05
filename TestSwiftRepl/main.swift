//
//  main.swift
//  TestSwiftRepl
//
//  Swift REPL terminal application.

import Foundation
import SwiftLLDB

SBDebugger.initialize()
let d = SBDebugger()
do {
    try d.runRepl(.Swift, options: "")
} catch {
    print("REPL failure: \(error)")
}
SBDebugger.terminate()
