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
    try d.runRepl(.Swift, options: "")
} catch {
    print("REPL failure: \(error)")
}
SBDebugger.tearDown()
