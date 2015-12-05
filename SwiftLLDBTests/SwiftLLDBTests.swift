//
//  SwiftLLDBTests.swift
//  SwiftLLDBTests
//

import XCTest
import SwiftLLDB

extension NSPipe {
    func readString() -> String {
        let data = self.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: data, encoding: NSUTF8StringEncoding) as! String
    }
}

class SwiftLLDBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        SBDebugger.initialize()
    }
    
    override func tearDown() {
        SBDebugger.terminate()
        super.tearDown()
    }
    
    func testREPL() {
        let d = SBDebugger()
        let inputPipe = NSPipe()
        let input = inputPipe.fileHandleForWriting
        input.writeData("for i in 0..<5 { print(\"Line \\(i)\") }\n\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        input.closeFile()
        let outputPipe = NSPipe()
        var result = ""
        outputPipe.fileHandleForReading.readabilityHandler = { handle in
            guard let output = NSString(data: handle.availableData, encoding: NSUTF8StringEncoding) as? String else { return }
            result += output
        }
        do {
            try d.setInputFileHandle(inputPipe.fileHandleForReading)
            try d.setOutputFileHandle(outputPipe.fileHandleForWriting)
            try d.runRepl(.Swift, options: "")
        } catch {
            print("REPL failure: \(error)")
        }
        
        XCTAssertEqual(result, "Line 0\r\nLine 1\r\nLine 2\r\nLine 3\r\nLine 4\r\n")
    }
    
}