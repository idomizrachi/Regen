//
//  Usage.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class Usage {
    
    let options = [ "--version" : "Prints the current version", "--output FILE" : "Set the generated file name (without extension)" ]
    
    func printUsage() {
        print("Usage:".bold.underline)
        levelPrint("$ Regen ")
        newLine()

        print("Options:".bold.underline)
        for (option,description) in options {
            levelPrint("\(option) - \(description)")
        }
        
    }
    
    func levelPrint(string : String) {
        print("\t" + string)
    }
    
    func newLine() {
        print("")
    }
    
}