//
//  Usage.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

class Usage {
    
    let options = [ ["--version          ", "Prints the current version"],
                    ["--output FILE      ", "Set the generated file name (without extension)"] ,
                    ["--scanType TYPE    ", "Use images or localization\n\t\timages - scans the projects .xcassets files\n\t\tlocalization - scans the projects Localizable.strings file"],
                    ["--language LANGUAGE", "Use swift or objc\n\t\tSets the language of the generated filess"],
                    ["--verbose or -v    ", "Print detailed information while running"]
    ]
    
    func printUsage() {
        print("Usage:".bold.underline)
        levelPrint("$ regen [options]")
        newLine()

        print("Options:".bold.underline)
        for (option) in options {
            levelPrint("\(option[0]) \t\t\t \(option[1])")
        }
    }
    
    func levelPrint(_ string : String) {
        print("\t" + string)
    }
    
    func newLine() {
        print("")
    }
    
}
